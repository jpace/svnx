#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/update/command'
require 'svnx/merge/command'
require 'svnx/commit/command'
require 'svnx/log/command'

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project
  attr_reader :dir
  attr_reader :url
  
  def initialize args
    @dir = args[:dir]
    @url = args[:url]
  end

  def where
    @url || @dir
  end
  
  def svn_command cmd
    runcmd = cmd + " " + where
    IO.popen(runcmd).readlines
  end

  def svn_url
    svn_info.url
  end
  
  def svn_mergeinfo args
    cargs = Array.new
    if args[:recurse]
      cargs << "-R"
    end
    cargs << where if where
    SWN::Commands.new.pg_mergeinfo cargs
  end

  def svn_path
    svn_info.path
  end

  def info args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    infcmd = Svnx::Info::Command.new cmdargs
    infcmd.entry
  end

  def update args = Hash.new
    cmdargs = { paths: [ @dir ], url: @url }.merge args
    cmd = Svnx::Update::Command.new cmdargs
    cmd.output
  end
  
  def merge args = Hash.new
    cmdargs = { paths: [ @dir ], url: @url }.merge args
    cmd = Svnx::Merge::Command.new cmdargs
    cmd.output
  end
  
  def commit args = Hash.new
    cmdargs = { paths: [ @dir ], url: @url }.merge args
    cmd = Svnx::Commit::Command.new cmdargs
    cmd.output
  end
  
  def log args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    cmd = Svnx::Log::Command.new cmdargs
    cmd.entries
  end

  def svn_diff(*args)
    cargs = args.dup
    cargs << where if where
    debug "cargs: #{cargs}"
    SWN::Commands.new.diff cargs
  end

  def to_s
    where.to_s
  end  
end
