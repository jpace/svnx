#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'

module Svnx::Base
  class MockCommandLine < CommandLine
    EXECUTED = Array.new
    
    attr_reader :executed
    attr_reader :subcommand
    attr_reader :xml
    attr_reader :caching
    attr_reader :args    
    
    def execute
      @executed = true
      EXECUTED << self
      ""
    end

    def self.latest_executed? cmd
      ex = EXECUTED[-1]
      ex && ex.subcommand.to_s == cmd.to_s && ex.executed
    end
  end
end
