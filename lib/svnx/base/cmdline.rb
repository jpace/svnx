#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
# require 'cmdline/line'
# require 'cmdline/caching'
require 'command/cacheable'
require 'svnx/base/env'

module Svnx
  module Base
  end
end

module Svnx::Base
  class CommandLine
    include Logue::Loggable

    attr_reader :output
    attr_reader :error
    attr_reader :status  

    def initialize subcommand: nil, xml: true, caching: false, args: Array.new
      debug "subcommand: #{subcommand}"
      debug "args: #{args}"
      @subcommand = subcommand
      @xml = xml
      @caching = caching
      @args = args
      debug "@args: #{@args}"
    end

    def execute
      cmdargs = [ 'svn', @subcommand ]
      cmdargs << '--xml' if @xml
      cmdargs.concat @args
      debug "cmdargs: #{cmdargs}"
      
      cmdline = command_line cmdargs
      cmdline.execute
      debug "cmdline: #{cmdline}"
      
      @output = cmdline.output
      @error = cmdline.error
      @status = cmdline.status

      @output
    end

    def command_line cmdargs
      Command::Cacheable::Command.new cmdargs, caching: @caching, dir: Svnx::Env.instance.cache_dir
    end
  end
end
