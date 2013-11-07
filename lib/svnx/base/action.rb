#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

module SVNx
  class Action
    include Logue::Loggable, Comparable
    
    attr_reader :type
    attr_reader :char

    STATUS_TO_TYPE = Hash.new
    STATUS_TO_ACTION = Hash.new

    def initialize type, char
      @type = type
      @char = char
    end

    class << self
      alias_method :orig_new, :new
      
      def new arg, char = nil
        if arg.kind_of? Action
          arg
        elsif act = STATUS_TO_ACTION[arg]
          act
        else
          type = STATUS_TO_TYPE[arg]
          raise "no such action: #{arg.inspect}" unless type
          STATUS_TO_ACTION[arg] = orig_new type, char
        end
      end

      def add_type str, char
        sym = str.to_sym
        STATUS_TO_TYPE[sym] = sym
        action = SVNx::Action.new sym, char
        SVNx::Action.const_set str.upcase, action
        [ sym, str, char ].each do |key|
          STATUS_TO_ACTION[key] = action
        end
      end
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
