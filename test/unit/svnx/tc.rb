#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'test/unit'

class Object
  def metaclass
    class << self
      self
    end
  end
end

module Svnx
  module Common
  end
end

class Svnx::Common::TestCase < Test::Unit::TestCase
  include Logue::Loggable

  class << self
    def add_execute_methods cls
      unless cls.method_defined? :executed  
        cls.metaclass.instance_eval do
          define_method("executed") do
            cls.metaclass.class_variable_get(:@@executed)
          end

          define_method("executed=") do |arg|
            cls.metaclass.class_variable_set(:@@executed, arg)
          end
        end

        cls.instance_eval do
          define_method("execute") do
            cls.executed = true
            Array.new
          end

          define_method("executed") do
            @@executed ||= nil
          end
        end
      end
    end
  end
end
