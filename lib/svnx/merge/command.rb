#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/merge/args'
require 'logue/loggable'
require 'svnx/base/cmdline'

class Svnx::Merge::CmdLine < Svnx::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Merge::Command
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
    
    opts = Svnx::Merge::Options.new cmdopts
    info "opts: #{opts}"
    args = Svnx::Merge::Args.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = Svnx::Merge::CmdLine.new "merge", cmdargs
    info "cmdline: #{cmdline}"
    @output = cmdline.execute
  end
end
