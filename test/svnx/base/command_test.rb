#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/command'
require 'svnx/tc'
require 'svnx/mock'
require 'paramesan'

module SvnxTest
  class MockCommand < Svnx::Base::Command
    caching
  end

  class MockOptions < Svnx::Base::Options
    attr_reader :abc
    
    def initialize args
      @abc = "ghi"
    end

    def options_to_args
      Array.new.tap do |a|
        a << [ :abc, @abc ]
      end
    end
  end  
end

module SvnxTest2
  module Nesting
    class MockCommand < Svnx::Base::Command
      caching
    end

    class Options < Svnx::Base::Options
      attr_reader :key
      
      def initialize args
        @key = "val"
      end

      def options_to_args
        Array.new.tap do |a|
          a << [ :key, @key ]
        end
      end
    end
  end
end

module Xyz
  class Options < Svnx::Base::Options
    def fields
      Hash.new
    end
  end
  
  class Command < Svnx::Base::EntriesCommand
    caching
  end
end

module Svnx::Base
  class CommandTest < Svnx::TestCase
    include Paramesan
    
    def self.build_params
      options = { file: "abc", paths: [ "def", "ghi" ] }
      command = SvnxTest::MockCommand.new options,           optcls: SvnxTest::MockOptions, cmdlinecls: MockCommandLine
      other   = SvnxTest2::Nesting::MockCommand.new options, cmdlinecls: MockCommandLine
      Array.new.tap do |a|
        a << [ SvnxTest::MockOptions,       command ]
        a << [ SvnxTest2::Nesting::Options, other   ]
      end
    end

    param_test build_params do |expoptcls, cmd|
      assert_equal expoptcls, cmd.options.class, "cmd: #{cmd}"
    end

    def test_default
      options = Hash.new
      Xyz::Command.new options
    end
  end
end
