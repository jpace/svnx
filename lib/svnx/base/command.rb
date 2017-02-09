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
  
  def initialize cls: Svnx::Base::CommandLine, xml: false, caching: caching?, entries_class: nil, options: Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries

    info "options: #{options}"

    cmdargs = nil

    melements = module_elements
    modl = find_module melements
    
    opts = modl::Options.new options
    info "opts: #{opts}"
    
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"

    subcommand = melements[-1].downcase
    info "subcommand: #{subcommand}"
    
    info "cls: #{cls}"

    @cmdline = cls.new subcommand: subcommand, xml: xml, caching: caching, args: cmdargs
    info "@cmdline: #{@cmdline}"

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
  
  def initialize cls: Svnx::Base::CommandLine, caching: caching?, xml: true, entries_class: nil, options: Hash.new
    super cls: cls, xml: xml, caching: caching, options: options
    
    if not @output.empty?
      if entries_class
        @entries = entries_class.new lines: @output
      else
        modl = find_module
        
        opts = modl::Options.new options
        info "opts: #{opts}"

        @entries = modl::Entries.new lines: @output
      end
    end
  end
end
