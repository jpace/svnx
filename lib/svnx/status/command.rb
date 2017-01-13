#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/args'
require 'svnx/status/entries'
require 'pp'

class Svnx::Status::CmdLine < Svnx::CommandLine
  def uses_xml?
    true
  end

  def caching?
    false
  end
end

class Svnx::Status::Command
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
    
    opts = Svnx::Status::Options.new cmdopts
    info "opts: #{opts}"
    args = Svnx::Status::Args.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = Svnx::Status::CmdLine.new "status", cmdargs
    info "cmdline: #{cmdline}"
    output = cmdline.execute
    
    # pp output
    
    unless output.empty?
      @entries = Svnx::Status::Entries.new xmllines: output
    end
  end
end
