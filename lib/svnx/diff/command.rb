#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/diff/args'
require 'logue/loggable'
require 'svnx/base/cmdline'
require 'svnx/diff/parser'

class SvnDiffCmdLine < SVNx::CachingCommandLine
  def uses_xml?
    false
  end
end

class SvnDiffCommand
  include Logue::Loggable
  
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    opts = SvnDiffOptions.new cmdopts
    info "opts: #{opts}"
    args = SvnDiffArgs.new opts
    info "args: #{args}"
    cmdargs = args.to_svn_args
    info "cmdargs: #{cmdargs}"
    cmdline = SvnDiffCmdLine.new "diff", cmdargs
    info "cmdline: #{cmdline}"
    output = cmdline.execute
    @entries = SvnDiffParser.new.parse_all_output output
  end
end
