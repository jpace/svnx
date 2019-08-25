#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command_factory'
require 'svnx/base/command'
require 'svnx/tc'

module M1
  module C2
    class Command < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
    end
  end

  module C3
    class Command < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
    end
  end
end

module Svnx::Base
  class CommandFactoryTest < Svnx::TestCase
    params = Array.new.tap do |a|
      a << [ [ M1::C2::Options, "c2" ], M1::C2::Command, Hash.new ]
      a << [ [ M1::C3::Options, "c3" ], M1::C3::Command, Hash.new ]
    end

    param_test params do |expected, cls, args|
      f = CommandFactory.new
      result = f.create cls
      
      assert_equal expected[0], result.options
    end

    param_test params do |expected, cls, args|
      f = CommandFactory.new
      result = f.create cls
      
      assert_equal expected[1], result.subcommand
    end
  end
end
