#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  module ObjectUtil
    # shortcut for "@var = args[:var]", for multiple variable names, which are symbols.
    def assign args, symbols = Array.new
      symbols.each do |symbol|
        instance_variable_set "@" + symbol.to_s, args[symbol]
      end
    end

    # raises an exception if any element in +args+ is not in +valid+.
    def validate args, valid = Array.new
      invalid = args.keys.reject do |field|
        valid.include? field
      end

      invalid.empty? || raise(create_invalid_fields_message invalid)
    end

    def create_invalid_fields_message fields
      Array.new.tap do |a|
        a << "invalid"
        a << (fields.size == 1 ? "field" : "fields" )
        a << "for"
        a << self.class.to_s + ":"
        a.concat fields
      end.join(" ")
    end

    module ClassMethods
      def attr_readers(*symbols)
        what = Array(symbols).flatten
        attr_reader(*what)
      end

      # Creates a reader method for each field, and assigns and validates them from an initialize
      # method, which is also created.
      def has_fields(*fields)
        what = Array(fields).flatten
        attr_reader(*what)
        
        define_method :initialize do |args|
          assign args, what
          validate args, what
        end
      end
    end

    extend ClassMethods

    def self.included other
      other.extend ClassMethods
    end
  end
end
