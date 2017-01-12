#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/info/args'
require 'logue/loggable'
require 'svnx/base/cmdline'

class SvnInfoCmdLine < SVNx::CommandLine
  def uses_xml?
    true
  end
end

class SvnInfoCommand
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
    
    opts = SvnInfoOptions.new cmdopts
    info "opts: #{opts}"
    args = SvnInfoArgs.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = SvnInfoCmdLine.new "info", cmdargs
    info "cmdline: #{cmdline}"
    output = cmdline.execute
    info "output: #{output}"
    
    # info has only one entry
    unless output.empty?
      entries = SVNx::Info::Entries.new xmllines: output
      @entry = entries[0]
    end
  end
end
