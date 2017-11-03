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

    module ClassMethods  
      def attr_readers symbols = Array.new
        symbols.each do |symbol|
          define_method symbol do 
            instance_variable_get "@" + symbol.to_s
          end
        end
      end
    end

    extend ClassMethods

    def self.included other
      other.extend ClassMethods
    end
  end
end
