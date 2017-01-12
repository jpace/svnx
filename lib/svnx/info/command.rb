#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/args'
require 'logue/loggable'
require 'svnx/base/cmdline'

class Svnx::Info::CmdLine < Svnx::CommandLine
  def uses_xml?
    true
  end
end

class Svnx::Info::Command
  include Logue::Loggable
  
  attr_reader :entry
  
  def initialize cmdopts = Hash.new
    # the pattern:

    # rawargs =>
    # options =>
    # svn args =>
    # command line =>
    # output =>
    # parser =>
    # entries
    
    opts = Svnx::Info::Options.new cmdopts
    info "opts: #{opts}"
    args = Svnx::Info::Args.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = Svnx::Info::CmdLine.new "info", cmdargs
    info "cmdline: #{cmdline}"
    output = cmdline.execute
    info "output: #{output}"
    
    # info has only one entry
    unless output.empty?
      entries = Svnx::Info::Entries.new xmllines: output
      @entry = entries[0]
    end
  end
end
