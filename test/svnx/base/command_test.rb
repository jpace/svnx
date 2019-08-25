#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/tc'

module SvnxTest
  module M1
    class Command < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
      has :file
    end
  end

  module M2
    class Command < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
      has :file
    end
  end  
end

module Svnx::Base
  class CommandTest < Svnx::TestCase
    params = Array.new.tap do |a|
      options = Hash.new
      cmd = SvnxTest::M1::Command.new options, cmdlinecls: Svnx::Base::MockCommandLine
      a << [ SvnxTest::M1::Options, "m1", cmd ]
      
      cmd = SvnxTest::M2::Command.new options, cmdlinecls: Svnx::Base::MockCommandLine
      a << [ SvnxTest::M2::Options, "m2", cmd ]
    end

    param_test params do |expopts, _, cmd|
      result = cmd.options_class
      assert_equal expopts, result
    end

    param_test params do |_, expsubcommand, cmd|
      result = cmd.subcommand
      assert_equal expsubcommand, result
    end
  end
end
