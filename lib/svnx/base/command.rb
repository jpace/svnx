#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/caching'
require 'svnx/base/cmdline'

class Svnx::Base::Command
  include Logue::Loggable

  attr_reader :output
  
  def initialize cls: Svnx::Base::CommandLine, xml: true, caching: false, options: Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries

    info "options: #{options}"
    
    mods = self.class.name.split "::"
    mod = mods[0 .. -2].join "::"
    modl = Kernel.const_get mod
    opts = modl::Options.new options
    
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"

    subcommand = mods[-2].downcase
    info "subcommand: #{subcommand}"

    info "cls: #{cls}"

    @cmdline = cls.new subcommand, xml, caching, cmdargs
    info "@cmdline: #{@cmdline}"

    @output = @cmdline.execute
  end
end
