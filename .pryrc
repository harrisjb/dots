require "rubygems"

require "active_record"
module ActiveRecord; end
#require "awesome_print"
require "irb/completion"
require "json"
require "nokogiri"
require "pp"

begin
  require 'awesome_print'
  Pry.print = proc do |output, value|
    if value.is_a?(Nori::StringWithAttributes)
      output.puts value.to_s
    elsif value.is_a?(Array) && value.first.is_a?(Hash)
      value.each do |h|
        output.puts h.each { |k, v| v.to_s }
      end
    else
      output.puts value.ai
    end
  end
rescue LoadError => e
  puts "no awesome_print :( ...Error: #{e}"
end

# Load 'awesome_print'
#begin
#  require 'awesome_print'
#  require 'awesome_print/ext/active_record'
#  require 'awesome_print/ext/active_support'
#  AwesomePrint.pry!
#rescue LoadError => err
#end

 #Load 'hirb'
#begin
  #require 'hirb'

  #Pry.config.print = proc do |output, value|
    #Hirb::View.view_or_page_output(value) || Pry::DEFAULT_PRINT.call(output, value)
  #end

  #Hirb.enable
#rescue LoadError => err
#end

# Launch Pry with access to the entire Rails stack
rails = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails2 or Rails3?)"
  end

  # Rails' pry prompt
  env = ENV['RAILS_ENV'] || Rails.env
  app = ENV['SE_APP_NAME'] || Rails.application.class.parent_name.downcase
  rails_root = File.basename(Dir.pwd)

  rails_env_prompt = case env
    when 'development'
      "#{app.upcase}" + ' [DEV]'
    when 'production' && app == "ship-it-staging"
      "#{app.upcase}" + ' [STAGING]'
    when 'production' && app == "ship-it"
      "#{app.upcase}" + ' [PROD]'
    else
      "#{app.upcase} [#{env.upcase}]"
    end

  prompt = '%s %s %s:%s'
  Pry.config.prompt = [ proc { |obj, nest_level, *| "#{prompt}> " % [rails_root, rails_env_prompt, obj, nest_level] },
                        proc { |obj, nest_level, *| "#{prompt}* " % [rails_root, rails_env_prompt, obj, nest_level] } ]

  # [] acts as find()
  ActiveRecord::Base.instance_eval { alias :[] :find } if defined?(ActiveRecord)

  # Add Rails console helpers (like `reload!`) to pry
  if defined?(Rails::ConsoleMethods)
    extend Rails::ConsoleMethods
  end

  # r! to reload Rails console
  def r!
    reload!
  end

  # automatically call `reload` every time a new command is typed
  Pry.hooks.add_hook(:before_eval, :reload_everything) { reload!(false) }

  # sql for arbitrary SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # set logging to screen
  if ENV.include?('RAILS_ENV')
    # Rails 2.x
    if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
      require 'logger'
      Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
    end
  else
    # Rails 3
    if Rails.logger and defined?(ActiveRecord)
      Rails.logger = Logger.new(STDOUT)
      ActiveRecord::Base.logger = Rails.logger
    end
  end

  # .details method for pretty printing ActiveRecord's objects attributes
  class Object
    def details
      if self.respond_to?(:attributes) and self.attributes.any?
        max = self.attributes.keys.sort_by { |k| k.size }.pop.size + 5
        puts
        self.attributes.keys.sort.each do |k|
          puts sprintf("%-#{max}.#{max}s%s", k, self.try(k))
        end
        puts
      end
    end
    alias :detailed :details
  end

  # returns a collection of the methods that Rails added to the given class
  # http://lucapette.com/irb/rails-core-ext-and-irb/
  class Class
    def core_ext
      self.instance_methods.map {|m| [m, self.instance_method(m).source_location] }.select {|m| m[1] && m[1][0] =~/activesupport/}.map {|m| m[0]}.sort
    end
  end

  # local methods helper
  # http://rakeroutes.com/blog/customize-your-irb/
  class Object
    def local_methods
      case self.class
      when Class
        self.public_methods.sort - Object.public_methods
      when Module
        self.public_methods.sort - Module.public_methods
      else
        self.public_methods.sort - Object.new.public_methods
      end
    end
  end
end
