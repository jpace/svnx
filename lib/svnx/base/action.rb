#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

module SVNx
  class Action
    include Logue::Loggable, Comparable
    
    attr_reader :type

    STATUS_TO_TYPE = Hash.new
    STATUS_TO_ACTION = Hash.new

    class << self
      alias_method :orig_new, :new
      
      def new str
        if act = STATUS_TO_ACTION[str]
          act
        else
          orig_new STATUS_TO_TYPE[str]
        end
      end

      def add_type str, char
        sym = str.to_sym
        STATUS_TO_TYPE[sym] = sym
        action = SVNx::Action.new(sym)
        SVNx::Action.const_set str.upcase, action
        [ sym, str, char ].each do |key|
          STATUS_TO_ACTION[key] = action
        end
      end
    end

    def initialize type
      @type = type
    end

    def <=> other
      @type <=> other.type
    end

    def to_s
      @type.to_s
    end

    add_type 'added', 'A'
    add_type 'deleted', 'D'
    add_type 'modified', 'M'
    add_type 'unversioned', '?'

    STATUS_TO_TYPE.values.uniq.each do |val|
      methname = val.to_s + '?'
      define_method methname do
        instance_eval do
          @type == STATUS_TO_TYPE[val]
        end
      end
    end    
  end
end
