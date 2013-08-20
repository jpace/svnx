#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/command'

module SVNx
  class StatusCommandLine < CommandLine
    def initialize args
      super "status", args.to_a
    end
  end

  class StatusCommandArgs < CommandArgs
    def to_a
      [ @path ].compact
    end
  end  

  class StatusCommand < Command
    def command_line
      StatusCommandLine.new @args
    end
  end

  class StatusExec
    attr_reader :entries
    
    def initialize args
      cmd = StatusCommand.new StatusCommandArgs.new(args)
      @entries = SVNx::Status::Entries.new(:xmllines => cmd.execute)
    end
  end
end
