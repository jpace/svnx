#!/usr/bin/ruby -w
# -*- ruby -*-

require 'command/cacheable/command'
require 'svnx/base/env'

module Svnx::Base
  class CommandLine
    attr_reader :output
    attr_reader :error
    attr_reader :status  

    def initialize subcommand: nil, xml: true, caching: false, args: Array.new
      @subcommand = subcommand
      @xml = xml
      @caching = caching
      @args = args
    end

    def command
      Array.new.tap do |a|
        a << 'svn'
        a << @subcommand
        if @xml
          a << '--xml'
        end
        a.concat @args
      end
    end

    def execute
      cmdline = ::Command::Cacheable::Command.new command, caching: @caching, cachedir: Svnx::Env.instance.cache_dir
      cmdline.execute
      
      @output = cmdline.output
      @error = cmdline.error
      @status = cmdline.status

      @output
    end
  end
end
