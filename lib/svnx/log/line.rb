#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/command'
require 'svnx/log/args'

module SvnLog
  module LogCmdLine
    # this can be either an Array (for which to_a returns itself), or
    # a CommandArgs, which also has to_a.
    def initialize args = Array.new
      super "log", args.to_a
    end
  end

  class LogCommandLine < SVNx::CommandLine
    include LogCmdLine
  end

  class LogCommandLineCaching < SVNx::CachingCommandLine
    include LogCmdLine
  end
  
  class CommandLine < SVNx::Command
    def initialize args
      @use_cache = args.use_cache
      super
    end

    def command_line
      cls = @use_cache ? LogCommandLineCaching : LogCommandLine
      cls.new @args
    end    
  end
end

module SVNx
  class LogCommand < SvnLog::CommandLine
  end
end
