#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'singleton'
require 'svnx/base/action_status'

module Svnx
  class Action
    include Logue::Loggable
    include Comparable
    
    attr_reader :type
    
    def initialize type
      sas = ActionStatus.instance
      unless @type = sas.symbol_for(type)
        raise "not a valid action type: #{type}"
      end
    end

    def <=> other
      @type <=> other.type
    end

    def to_s
      @type.to_s
    end
    
    sas = ActionStatus.instance
    sas.stati.each do |str|
      action = Action.new str
      Action.const_set str.upcase, action
      
      methname = str + '?'
      define_method methname do
        instance_eval do
          sym = ActionStatus.instance.symbol_for str
          @type.to_sym == sym
        end
      end      
    end  
  end
end
