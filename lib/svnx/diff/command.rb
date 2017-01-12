#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/diff/args'
require 'logue/loggable'
require 'svnx/base/cmdline'
require 'svnx/diff/parser'

class Svnx::Diff::CmdLine < Svnx::CommandLine
  def uses_xml?
    false
  end

  def caching?
    true
  end

  def subcommand
    "diff"
  end
end

class Svnx::Diff::Command
  include Logue::Loggable
  
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries
    
    opts = Svnx::Diff::Options.new cmdopts
    info "opts: #{opts}"
    args = Svnx::Diff::Args.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = Svnx::Diff::CmdLine.new "diff", cmdargs
    info "cmdline: #{cmdline}"
    cmdline.execute
    output = cmdline.output
    debug "output: #{output}"
    @entries = Svnx::Diff::Parser.new.parse_all_output output
  end
end
