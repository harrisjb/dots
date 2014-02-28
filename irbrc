require "rubygems"

require "active_record"
module ActiveRecord; end
require "awesome_print"
require "irb/completion"
require "json"
require "nokogiri"
require "nori"
require "pp"
require "wirble"

#colorize irb output
Wirble.init(:skip_prompt => true, :skip_history => true)
Wirble.colorize

#auto indent for nice blocks and methods
IRB.conf[:AUTO_INDENT]=true

# Initialize Hirb
if defined?(Hirb)
  Hirb.enable
end

#pretty print JSON
def jp(json_text)
  puts JSON.pretty_generate json_text
end

#Log to STDOUT if in Rails
if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# .local_methods method for all classes
class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end

# Documentation
# #
# # ri 'Array#pop'
# # Array.ri
# # Array.ri :pop
# # arr.ri :pop

class Object
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}' `
  end

  def pbcopy(string)
    IO.popen('pbcopy', 'w') { |f| f.puts(string) }
    nil
  end
end

# keep output manageable
class Array
  alias :__orig_inspect :inspect
  def inspect
    (length > 100) ? "[ ... #{length} elements ... ]" : __orig_inspect
  end
end

class Hash
  alias :__orig_inspect :inspect
  def inspect
    (length > 100) ? "{ ... #{length} keys ... }" : __orig_inspect
  end
end
