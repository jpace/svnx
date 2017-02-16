#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'logue/log'
require 'resources'
require 'rainbow'
require 'svnx/base/cmdline'

# no verbose if running all tests:
level = ARGV.size > 1 ? Logue::Log::WARN : Logue::Log::DEBUG

puts "ARGV: #{ARGV}"
puts "level: #{level}"

Logue::Log.level = Logue::Log::DEBUG
Logue::Log.set_widths(-35, 4, -35)

# produce colorized output, even when redirecting to a file:
Rainbow.enabled = true

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

class Svnx::Base::MockCommandLine < Svnx::Base::CommandLine
  attr_reader :executed
  
  def execute
    info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    info "self: #{self}"
    @executed = true
    Array.new
  end
end
