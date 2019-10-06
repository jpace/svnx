#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/tc'

module SvnxTest
  module M1
    class Command < Svnx::Base::Command
      caching
      nonxml
    end

    class Options < Svnx::Base::Options
      has :file
    end
  end

  module M2
    class Command < Svnx::Base::Command
      noncaching
      xml
    end

    class Options < Svnx::Base::Options
#      has :file
    end
  end  

  module M3
    class Command < Svnx::Base::Command
    end

    class Options < Svnx::Base::Options
      has :file
    end
  end  
end

module Svnx::Base
  class CommandTest < Svnx::TestCase
    param_test [
      [ SvnxTest::M1::Options, SvnxTest::M1::Command ],
      [ SvnxTest::M2::Options, SvnxTest::M2::Command ],
    ] do |expected, cmdcls|
      cmd = cmdcls.new Hash.new, cmdlinecls: MockCommandLine
      result = cmd.options_class
      assert_equal expected, result
    end

    param_test [
      [ "m1",  SvnxTest::M1::Command ],
      [ "m2",  SvnxTest::M2::Command ],
    ] do |expected, cmdcls|
      cmd = cmdcls.new Hash.new, cmdlinecls: MockCommandLine
      result = cmd.subcommand
      assert_equal expected, result
    end

    param_test [
      [ true,  SvnxTest::M1::Command ],
      [ false, SvnxTest::M2::Command ],
      [ false, SvnxTest::M3::Command ],
    ] do |expected, cmdcls|
      cmd = cmdcls.new Hash.new, cmdlinecls: MockCommandLine
      assert_equal expected, cmd.caching?
    end

    param_test [
      [ false, SvnxTest::M1::Command ], 
      [ true,  SvnxTest::M2::Command ], 
      [ true,  SvnxTest::M3::Command ], 
    ] do |expected, cmdcls|
      cmd = cmdcls.new Hash.new, cmdlinecls: MockCommandLine
      assert_equal expected, cmd.xml?
    end
  end
end
