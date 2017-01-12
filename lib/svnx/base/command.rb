#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/caching'
require 'svnx/base/args'
require 'svnx/base/cmdline'

# this replaces svnx/lib/command/svncommand.

module Svnx
  class Command
    include Logue::Loggable

    attr_reader :output
    
    def initialize args
      @args = args
    end

    def command_line
      raise "must be implemented"
    end
    
    def execute
      cmdline = command_line
      cmdline.execute
      @output = cmdline.output
    end
  end
end
