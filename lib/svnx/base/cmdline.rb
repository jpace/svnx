#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'system/command/line'
require 'system/command/caching'

module SVNx
  DEFAULT_CACHE_DIR = '/tmp/svnx'
  TMP_DIR_ENV_VARNAME = 'SVNX_TMP_DIR'

  module CmdLine
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
      ENV[TMP_DIR_ENV_VARNAME] || DEFAULT_CACHE_DIR
    end
  end

  class CommandLine < System::CommandLine
    include CmdLine
  end

  class CachingCommandLine < System::CachingCommandLine
    include CmdLine
  end
end
