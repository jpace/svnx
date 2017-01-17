#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
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

    mod = Svnx::Merge
    info "mod: #{mod}"

    opts = mod::Options.new cmdopts
    info "opts: #{opts}"
    
    cmdargs = opts.to_args
    info "cmdargs: #{cmdargs}"
    
    cmdline = mod::CmdLine.new "merge", cmdargs
    info "cmdline: #{cmdline}"
    
    @output = cmdline.execute
  end
end
