#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/env'

module Svnx::CommonCmdLine
  include Logue::Loggable

  def initialize subcmd, args
    cmdargs = [ 'svn', subcmd ]
    cmdargs << '--xml' if uses_xml?
    cmdargs.concat args
    super cmdargs
  end

  def uses_xml?
    true
  end

  def cache_dir
    Svnx::Env.instance.cache_dir
  end
end

class Svnx::CommandLine < System::CommandLine
  include Svnx::CommonCmdLine
end

class Svnx::CachingCommandLine < System::CachingCommandLine
  include Svnx::CommonCmdLine
end
