#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/command'
require 'logue/loggable'
require 'svnx/log/args'

module SVNx
  module LogCmdLine
    # this can be either an Array (for which to_a returns itself), or
    # a CommandArgs, which also has to_a.
    def initialize args = Array.new
      super "log", args.to_a
    end
  end

  class LogCommandLine < CommandLine
    include LogCmdLine
  end

  class LogCommandLineCaching < CachingCommandLine
    include LogCmdLine
  end
  
  class LogCommand < Command
    def initialize args
      @use_cache = args.use_cache
      super
    end

    def command_line
      cls = @use_cache ? LogCommandLineCaching : LogCommandLine
      cls.new @args
    end
  end

  class LogExec
    attr_reader :entries
    
    def initialize args
      cmd = LogCommand.new LogCommandArgs.new(args)
      entcls = args[:entries_class] || SVNx::Log::Entries
      @entries = entcls.new :xmllines => cmd.execute
    end
  end
end
