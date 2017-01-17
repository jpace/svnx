#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/caching'
require 'svnx/base/args'
require 'svnx/base/cmdline'

# this replaces svnx/lib/command/svncommand.

module Svnx
  class Command
    include Logue::Loggable

    attr_reader :output
    
    def initialize args
      @args = args
    end

    def command_line
      raise "must be implemented"
    end
    
    def execute
      cmdline = command_line
      cmdline.execute
      @output = cmdline.output
    end
  end
end

# the new command class:

module Svnx
  module Base
  end
end

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
    info "mods: #{mods}"
    
    mod = mods[0 .. -2].join "::"
    info "mod: #{mod}"

    modl = Kernel.const_get mod
    info "modl: #{modl.class}"
    
    opts = modl::Options.new cmdopts
    info "opts: #{opts.inspect}"

    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"

    subcommand = mods[-2].downcase
    info "subcommand: #{subcommand}"
    
    @cmdline = modl::CommandLine.new subcommand, cmdargs
    info "@cmdline: #{@cmdline}"    
  end
end
