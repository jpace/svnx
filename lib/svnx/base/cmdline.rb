#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'cmdline/line'
require 'cmdline/caching'
require 'svnx/base/env'

module Svnx
  module Base
  end
end

class Svnx::Base::CachingCommandLine < CmdLine::CachingCommandLine
  def caching?
    true
  end

  def cache_dir
    Svnx::Env.instance.cache_dir
  end
end

class Svnx::Base::CommandLine
  include Logue::Loggable

  attr_reader :output
  attr_reader :error
  attr_reader :status  

  def initialize subcommand: nil, xml: true, caching: false, args: Array.new
    @subcommand = subcommand
    @xml = xml
    @caching = caching
    @args = args
  end

  def execute
    cmdargs = [ 'svn', @subcommand ]
    cmdargs << '--xml' if @xml
    cmdargs.concat @args
    debug "cmdargs: #{cmdargs}"
    
    cmdline = if @caching
                Svnx::Base::CachingCommandLine.new cmdargs
              else
                CmdLine::CommandLine.new cmdargs
              end
    cmdline.execute
    debug "cmdline: #{cmdline}"
      
    @output = cmdline.output
    @error = cmdline.error
    @status = cmdline.status

    @output
  end
end
