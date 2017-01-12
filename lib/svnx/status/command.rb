#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/info/command'

module Svnx
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
      path = args[:path]
      rootpath = nil
      
      while true
        begin
          inf = InfoExec.new(path: path).entry
          rootpath = inf.wc_root
          break
        rescue
          path = Pathname.new(path).dirname.to_s
          break if path == '/'
        end
      end

      cmd = StatusCommand.new StatusCommandArgs.new(args)
      @entries = Svnx::Status::Entries.new(xmllines: cmd.execute, rootpath: rootpath)
    end
  end
end
