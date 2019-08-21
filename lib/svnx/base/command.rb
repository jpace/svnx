#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/util/classutil'
require 'svnx/base/command_factory'

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
    attr_reader :options
    
    def initialize options, cmdlinecls: nil, optcls: nil, xml: false, caching: caching?
      debug "options: #{options}"
      factory = CommandFactory.new

      params = factory.create self.class, cmdlinecls: cmdlinecls, optcls: optcls
      
      optcls ||= params.options
      debug "optcls: #{optcls}"
      
      @options = optcls.new options
      cmdargs = @options.to_args
      debug "cmdargs: #{cmdargs}"
      
      subcommand = params.subcommand
      
      cmdlinecls ||= params.cmdline

      debug "subcommand: #{subcommand}"
      
      @cmdline = cmdlinecls.new(subcommand: subcommand, xml: xml, caching: caching, args: cmdargs)
      debug "@cmdline: #{@cmdline}"
      
      @output = @cmdline.execute
      debug "@output: #{@output}"
      
      @error = @cmdline.error
      @status = @cmdline.status
    end
  end

  class EntriesCommand < Command
    attr_reader :entries
    
    def initialize options, cmdlinecls: CommandLine, caching: caching?, xml: true, entries_class: nil
      super options, cmdlinecls: cmdlinecls, xml: xml, caching: caching
      
      if not @output.empty?
        entries_class ||= begin
                            modl = ClassUtil.find_module self.class
                            modl::Entries
                          end
        
        @entries = entries_class.new @output
      end
    end
  end
end
