#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command_factory'
require 'svnx/base/command'
require 'svnx/base/options'
require 'svnx/tc'

module M1
  class Cmd < Svnx::Base::Command
    caching
  end

  class Opts < Svnx::Base::Options
  end  
end

module M2
  module C2
    class Cmd < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
    end

    class CmdLine < Svnx::Base::CommandLine
    end
  end
end

module Svnx::Base
  class CommandFactoryTest < Svnx::TestCase
    params = Array.new.tap do |a|
      a << [ M2::C2::Options, "c2", CommandLine,     M2::C2::Cmd, Hash.new                    ]
      a << [ M2::C2::Options, "c2", M2::C2::CmdLine, M2::C2::Cmd, cmdlinecls: M2::C2::CmdLine ]
    end

    param_test params do |expoptcls, _, _, cls, args|
      f = CommandFactory.new
      params = f.create cls, args
      
      assert_equal expoptcls, params.options
    end

    param_test params do |_, expsubcmd, _, cls, args|
      f = CommandFactory.new
      params = f.create cls, args
      
      assert_equal expsubcmd, params.subcommand
    end

    param_test params do |_, _, expcmdlinecls, cls, args|
      f = CommandFactory.new
      params = f.create cls, args
      
      assert_equal expcmdlinecls, params.cmdline
    end
  end
end
