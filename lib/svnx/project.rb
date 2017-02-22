#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/update/command'
require 'svnx/merge/command'
require 'svnx/commit/command'
require 'svnx/log/command'
require 'svnx/propget/command'
require 'svnx/propset/command'
require 'svnx/diff/command'

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project
  attr_reader :dir
  
  def initialize dir: nil, url: nil, exec: nil
    @dir = dir
    @url = url
    @exec = exec
  end

  def where
    @url || @dir
  end
  
  def url
    @url ||= begin
               entries = info
               entries && entries[0].url
             end
  end
  
  def mergeinfo args
    cargs = Array.new
    if args[:recurse]
      cargs << "-R"
    end
    cargs << where if where
    SWN::Commands.new.pg_mergeinfo cargs
  end

  def path
    info.path
  end

  def run_command cmdcls, cmdargs, args, exec: nil
    cmdargs = cmdargs.merge args
    cmd = cmdcls.new cmdargs, exec: exec
    cmd.respond_to?(:entries) ? cmd.entries : cmd.output
  end

  def path_url
    { path: @dir, url: @url }
  end

  def paths_url
    { paths: [ @dir ], url: @url }
  end
  
  def info args = Hash.new, exec: @exec
    run_command Svnx::Info::Command, path_url, args, exec: exec
  end

  def update args = Hash.new, exec: @exec
    run_command Svnx::Update::Command, paths_url, args, exec: exec
  end
  
  def merge args = Hash.new, exec: @exec
    run_command Svnx::Merge::Command, paths_url, args, exec: exec
  end
  
  def commit args = Hash.new, exec: @exec
    run_command Svnx::Commit::Command, paths_url, args, exec: exec
  end
  
  def log args = Hash.new, options: nil, exec: @exec
    run_command Svnx::Log::Command, path_url, options || args, exec: exec
  end

  def diff args = Hash.new, exec: @exec
    run_command Svnx::Diff::Command, path_url, args, exec: exec
  end

  def propset args = Hash.new, exec: @exec
    run_command Svnx::Propset::Command, path_url, args, exec: exec
  end

  def propget args = Hash.new, exec: @exec
    run_command Svnx::Propget::Command, path_url, args, exec: exec
  end

  def to_s
    where.to_s
  end  
end
