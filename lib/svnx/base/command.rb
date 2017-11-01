#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'cmdline/caching'
require 'svnx/base/cmdline'
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
    
    def initialize options, cls: nil, optcls: nil, exec: nil, xml: false, caching: caching?
      info "cls: #{cls}"
      
      factory = CommandFactory.new
      params = factory.create self.class, cmdlinecls: cls, optcls: optcls
      info "params: #{params}"
      
      optcls ||= params[:options_class]
      
      @options = optcls.new options
      cmdargs = @options.to_args
      subcommand = params[:subcommand]
      
      cls ||= params[:command_line_class]
      
      @cmdline = exec || cls.new(subcommand: subcommand, xml: xml, caching: caching, args: cmdargs)
      debug "@cmdline: #{@cmdline}"
      
      @output = @cmdline.execute
      debug "@output: #{@output}"
      @error = @cmdline.error
      debug "@error: #{@error}"
      @status = @cmdline.status
      debug "@status: #{@status}"
    end

    def module_elements
      mods = self.class.name.split "::"
      mods[0 .. -2]
    end

    def find_module elements = module_elements
      ClassUtil::Util.find_module self.class
    end
  end

  class EntriesCommand < Command
    attr_reader :entries
    
    def initialize options, cls: CommandLine, exec: nil, caching: caching?, xml: true, entries_class: nil
      super options, cls: cls, exec: exec, xml: xml, caching: caching
      
      if not @output.empty?
        entries_class ||= begin
                            modl = ClassUtil::Util.find_module self.class
                            modl::Entries
                          end
        
        @entries = entries_class.new lines: @output
      end
    end
  end
end
