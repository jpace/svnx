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

    def validate args, valid = Array.new
      invalid = args.keys.reject do |field|
        valid.include? field
      end

      if invalid.empty?
        true
      else
        msg = "invalid "
        msg << (invalid.size == 1 ? "field" : "fields" )
        msg << " for "
        msg << self.class.to_s
        msg << ": "
        msg << invalid.join(' ')
        raise msg
      end
    end

    module ClassMethods  
      def attr_readers symbols = Array.new
        attr_reader(*symbols)
      end

      def has_fields fields
        attr_reader(*fields)
        
        define_method :initialize do |args|
          assign args, fields
          validate args, fields
        end
      end
    end

    extend ClassMethods

    def self.included other
      puts "other: #{other}"
      other.extend ClassMethods
    end
  end
end
