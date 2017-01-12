#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/env'

class Svnx::CachingCommandLine < System::CachingCommandLine
  def caching?
    true
  end

  def cache_dir
    Svnx::Env.instance.cache_dir
  end
end

class Svnx::CommandLine
  include Logue::Loggable

  attr_reader :output
  attr_reader :error
  attr_reader :status  

  def initialize subcmd, args
    @subcmd = subcmd
    @args = args
  end

  def execute
    cmdargs = [ 'svn', @subcmd ]
    cmdargs << '--xml' if uses_xml?
    cmdargs.concat args

    cmdline = if caching?
                Svnx::CachingCommandLine.new cmdargs
              else
                System::CommandLine.new cmdargs
              end
    cmdline.execute
      
    @output = cmdline.output
    @error = cmdline.error
    @status = cmdline.status
  end

  def uses_xml?
    true
  end

  def caching?
    false
  end
end
