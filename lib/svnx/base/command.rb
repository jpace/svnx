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

    mods = self.class.name.split "::"
    info "mods: #{mods}"
    
    mod = mods[0 .. -2].join "::"
    info "mod: #{mod}"
    
    modl = Kernel.const_get mod
    info "modl: #{modl}"
    
    opts = modl::Options.new options
    info "opts: #{opts}"
    
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"

    subcommand = mods[-2].downcase
    info "subcommand: #{subcommand}"
    
    info "cls: #{cls}"

    @cmdline = cls.new subcommand: subcommand, xml: xml, caching: caching, args: cmdargs
    info "@cmdline: #{@cmdline}"

    @output = @cmdline.execute
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
        @entries = modl::Entries.new lines: @output
      end
    end
  end
end
