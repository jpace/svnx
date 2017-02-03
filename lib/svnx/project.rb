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
  
  def initialize args
    @dir = args[:dir]
    @url = args[:url]
  end

  def where
    @url || @dir
  end
  
  def url
    @url ||= begin
               entries = info path: @dir
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

  def info args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    cmd = Svnx::Info::Command.new cmdargs
    cmd.entries
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

  def diff args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    cmd = Svnx::Diff::Command.new cmdargs
    cmd.entries
  end

  def propset args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    cmd = Svnx::Propset::Command.new cmdargs
    cmd.output
  end

  def propget args = Hash.new
    cmdargs = { path: @dir, url: @url }.merge args
    cmd = Svnx::Propget::Command.new cmdargs
    cmd.entries
  end

  def to_s
    where.to_s
  end  
end
