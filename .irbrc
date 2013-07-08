require "rubygems"

require "active_record"
module ActiveRecord; end
require "awesome_print"
require "irb/completion"
require "json"
require "nokogiri"
require "pp"
require "wirble"

Wirble.init(:skip_prompt => true, :skip_history => true)
Wirble.colorize

IRB.conf[:AUTO_INDENT]=true

def jp(json_text)
  puts JSON.pretty_generate json_text
end

#Log to STDOUT if in Rails
if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
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
