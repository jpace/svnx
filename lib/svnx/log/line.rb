#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/command'

module Svnx::Log::CommonCmdLine
  # this can be either an Array (for which to_a returns itself), or
  # a CommandArgs, which also has to_a.
  def initialize args = Array.new
    super "log", args.to_a
  end
end

class Svnx::Log::CmdLine < Svnx::CommandLine
  include Svnx::Log::CommonCmdLine
end

class Svnx::Log::CmdLineCaching < Svnx::CachingCommandLine
  include Svnx::Log::CommonCmdLine
end

class Svnx::Log::CmdLine < Svnx::CommandLine
  def initialize caching, args
    @caching = caching
    super args
  end
  
  def caching?
    @caching
  end

  def uses_xml?
    true
  end
end

class Svnx::Log::CommandLine < Svnx::Command
  def initialize args
    @use_cache = args.use_cache
    super
  end
  
  def command_line
    cls = Svnx::Log::CmdLine
    cls.new @use_cache, @args
  end
end
