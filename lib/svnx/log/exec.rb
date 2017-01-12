#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/command'
require 'logue/loggable'
require 'svnx/log/args'
require 'svnx/log/entries'
require 'svnx/log/line'

module SvnLog
  class Exec
    attr_reader :entries
    
    def initialize args
      cmd = Svnx::Log::CommandLine.new Svnx::Log::Args.new(args)
      entcls = args[:entries_class] || Svnx::Log::Entries
      @entries = entcls.new :xmllines => cmd.execute
    end
  end
end

module Svnx
  class LogExec < SvnLog::Exec
  end
end
