#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/command'
require 'svnx/tc'

module Svnx::Base
  class MockCommand < Command
    caching
  end

  class MockOptions < Options
    attr_reader :abc
    
    def initialize args
      @abc = "ghi"
    end

    def options_to_args
      Array.new.tap do |optargs|
        optargs << [ :abc, @abc ]
      end
    end
  end

  class CommandTest < Svnx::Common::TestCase
    def test_command
      options = { file: "abc", paths: [ "def", "ghi" ] }
      MockCommand.new options, optcls: MockOptions, cls: MokkCommandLine
      cl = COMMAND_LINE_HISTORY[-1]
      info "cl: #{cl}"
      assert_equal true, cl.executed
      assert_equal "base", cl.subcommand
      assert_equal false, cl.xml
      assert_equal %w{ ghi }, cl.args
    end
  end
end
