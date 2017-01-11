#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/merge/args'
require 'logue/loggable'
require 'svnx/base/cmdline'

class SvnMergeCmdLine < SVNx::CommandLine
  def uses_xml?
    false
  end
end

class SvnMergeCommand
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
    
    opts = SvnMergeOptions.new cmdopts
    info "opts: #{opts}"
    args = SvnMergeArgs.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = SvnMergeCmdLine.new "merge", cmdargs
    info "cmdline: #{cmdline}"
    @output = cmdline.execute
  end
end
