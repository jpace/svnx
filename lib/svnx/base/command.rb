#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/caching'
require 'svnx/base/cmdline'

class Svnx::Base::Command
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
  
  def initialize options, cls: Svnx::Base::CommandLine, exec: nil, xml: false, caching: caching?
    info "options:: #{options}"
    melements = module_elements
    modl = find_module melements    
    opts = modl::Options.new options
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"
    subcommand = melements[-1].downcase

    info "exec: #{exec}"

    @cmdline = exec || cls.new(subcommand: subcommand, xml: xml, caching: caching, args: cmdargs)
    
    @output = @cmdline.execute
    @error = @cmdline.error
    @status = @cmdline.status
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

class Svnx::Base::EntriesCommand < Svnx::Base::Command
  attr_reader :entries
  
  def initialize options, cls: Svnx::Base::CommandLine, exec: nil, caching: caching?, xml: true, entries_class: nil
    info "cls: #{cls}"
    info "self: #{self}"
    info "options: #{options}"
    
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
