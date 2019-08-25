#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/util/classutil'
require 'svnx/base/options'
require 'svnx/base/command_factory'
require 'svnx/base/command_line_factory'

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
    end

    attr_reader :output
    attr_reader :error
    attr_reader :status
    
    def initialize options, cmdlinecls: nil, caching: caching?
      cmdargs = read_options options

      if cmdlinecls
        @cmdline = cmdlinecls.new subcommand: subcommand, xml: xml?, caching: caching, args: cmdargs
      else
        cmdfactory = CommandFactory.new
        clfactory = cmdfactory.command_line_factory
        @cmdline = clfactory.create subcommand: subcommand, xml: xml?, caching: caching, args: cmdargs
      end
      
      @output = @cmdline.execute
      @error = @cmdline.error
      @status = @cmdline.status
    end

    def xml?
      false
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
