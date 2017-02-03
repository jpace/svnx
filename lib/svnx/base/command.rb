#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/caching'
require 'svnx/base/cmdline'

class Svnx::Base::Command
  include Logue::Loggable
  
  def initialize cmdopts = Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries

    info "cmdopts: #{cmdopts}"
    
    mods = self.class.name.split "::"
    mod = mods[0 .. -2].join "::"
    modl = Kernel.const_get mod
    opts = modl::Options.new cmdopts
    
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"

    subcommand = mods[-2].downcase
    info "subcommand: #{subcommand}"
    
    @cmdline = Svnx::Base::CommandLine.new subcommand, uses_xml?, caching?, cmdargs
    info "@cmdline: #{@cmdline}"
  end

  def uses_xml?
    false
  end

  def caching?
    false
  end
end
