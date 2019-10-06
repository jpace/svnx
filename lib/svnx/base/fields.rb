#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  module Base
  end
end

module Svnx::Base
  module Fields
    # shortcut for "@var = args[:var]", for multiple variable names, which are symbols.
    def assign args, symbols = Array.new
      symbols.each do |symbol|
        instance_variable_set "@" + symbol.to_s, args[symbol]
      end
    end

    # raises an exception if any element in +args+ is not in +valid+.
    def validate args, valid = Array.new
      invalid = args.keys.reject { |field| valid.include? field }
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

    def fields
      # instance variable on the class itself, not an instance of the class
      varname = '@fields'
      cls = self.class
      if cls.instance_variable_defined? varname
        cls.instance_variable_get varname
      else
        Hash.new
      end
    end

    module ClassMethods
      def attr_readers(*symbols)
        what = Array(symbols).flatten
        attr_reader(*what)
      end
      
      def has_fields fields = Hash.new
        fields.each do |name, arg|
          has_field name, arg
        end        
      end

      def has_field name, arg
        @fields ||= Hash.new
        @fields[name] = arg
        
        attr_reader name
      end
    end

    extend ClassMethods

    def self.included other
      other.extend ClassMethods
    end
  end
end
