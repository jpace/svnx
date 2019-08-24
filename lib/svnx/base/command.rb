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
      cmdfactory = CommandFactory.new
      params = cmdfactory.create self.class, cmdlinecls: cmdlinecls
      
      @options = params.options.new options
      cmdargs = @options.to_args
      
      cmdlinecls ||= params.cmdline

      clfactory = CommandLineFactory.new
      
      @cmdline = clfactory.create params: params, cls: cmdlinecls, xml: xml?, caching: caching, args: cmdargs
      @output = @cmdline.execute
      @error = @cmdline.error
      @status = @cmdline.status
    end

    def xml?
      false
    end
  end

  class EntriesCommand < Command
    attr_reader :entries
    
    def initialize options, cmdlinecls: nil, caching: caching?
      super options, cmdlinecls: cmdlinecls, caching: caching
      
      @entries = if not @output.empty?
                   entries_class = begin
                                     modl = ClassUtil.find_module self.class
                                     modl::Entries
                                   end
                   entries_class.new @output
                 end
    end

    def xml?
      true
    end
  end
end
