#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'cmdline/caching'
require 'svnx/base/cmdline'

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
    
    def initialize options, cls: nil, optcls: nil, exec: nil, xml: false, caching: caching?
      info "cls:: #{cls}"
      melements = module_elements
      info "melements: #{melements}"
      modl = find_module melements    
      info "modl: #{modl}"
      unless optcls
        optcls = modl::Options
      end
      opts = optcls.new options
      info "opts: #{opts}"
      cmdargs = opts.to_args
      info "cmdargs: #{cmdargs}"
      subcommand = melements[-1].downcase
      info "subcommand: #{subcommand}"
      info "cls: #{cls}"
      info "caching: #{caching}"
      info "xml: #{xml}"
      info "exec: #{exec}"

      cls ||= CommandLine
      
      @cmdline = exec || cls.new(subcommand: subcommand, xml: xml, caching: caching, args: cmdargs)
      info "@cmdline: #{@cmdline}"
      
      @output = @cmdline.execute
      info "@output: #{@output}"
      @error = @cmdline.error
      info "@error: #{@error}"
      @status = @cmdline.status
      info "@status: #{@status}"
    end

    def module_elements
      mods = self.class.name.split "::"
      mods[0 .. -2]
    end

    def find_module elements = module_elements
      mod = elements * "::"
      Kernel.const_get mod
    end
  end

  class EntriesCommand < Command
    attr_reader :entries
    
    def initialize options, cls: CommandLine, exec: nil, caching: caching?, xml: true, entries_class: nil
      super options, cls: cls, exec: exec, xml: xml, caching: caching
      
      if not @output.empty?
        entries_class ||= begin
                            modl = find_module
                            modl::Entries
                          end
        
        @entries = entries_class.new lines: @output
      end
    end
  end
end
