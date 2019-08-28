#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/base/command_line_factory'

module Svnx::Base
  class MockCommandLine < CommandLine
    attr_reader :executed
    attr_reader :subcommand
    attr_reader :xml
    attr_reader :caching
    attr_reader :args

    @@all_executed = Array.new
    
    def execute
      @executed = true
      @@all_executed << self
      ""
    end

    def self.latest_executed? cmd
      ex = @@all_executed.last
      ex && ex.subcommand.to_s == cmd.to_s && ex.executed
    end

    def self.all_executed
      @@all_executed
    end
  end

  class MockCommandLineFactory < CommandLineFactory
    def create params: nil, cls: nil, xml: nil, caching: nil, args: nil
      MockCommandLine.new subcommand: params.subcommand, xml: xml, caching: caching, args: args
    end    
  end
end
