#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/propset/args'
require 'logue/loggable'
require 'svnx/base/cmdline'

class Svnx::Propset::CmdLine < Svnx::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Propset::Command
  include Logue::Loggable
  
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries
    
    opts = Svnx::Propset::Options.new cmdopts
    info "opts: #{opts}"
    args = Svnx::Propset::Args.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = Svnx::Propset::CmdLine.new "propset", cmdargs
    info "cmdline: #{cmdline}"
    @output = cmdline.execute
  end
end
