#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/util/classutil'
require 'svnx/base/options'
require 'svnx/base/cmdline_factory'

Logue::Log.level = Logue::Level::DEBUG

module Svnx::Base
  class Command
    include Logue::Loggable
    
    class << self
      def caching
        define_method :caching? do
          true
        end
      end

      def noncaching
        define_method :caching? do
          false
        end
      end

      def xml
        define_method :xml? do
          true
        end
      end

      def nonxml
        define_method :xml? do
          false
        end
      end
    end

    attr_reader :output
    attr_reader :error
    attr_reader :status
    
    def initialize options, cmdlinecls: nil, caching: caching?
      cmdargs = read_options options

      params = { subcommand: subcommand, xml: xml?, caching: caching, args: cmdargs }

      cmdline = if cmdlinecls
                  cmdlinecls.new params
                else
                  clfactory = CommandLineFactory.new
                  clfactory.create params
                end
      
      @output = cmdline.execute
      @error = cmdline.error
      @status = cmdline.status
    end

    def caching?
      false
    end

    def xml?
      true
    end

    def read_options args
      opts = options_class.new args
      opts.to_args
    end

    def options_class
      modl = ClassUtil.find_module self.class
      modl::Options
    end

    def subcommand
      melements = ClassUtil.module_elements self.class
      melements[-1].downcase
    end
  end
end
