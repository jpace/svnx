#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'system/command/line'

Logue::Log.level = Logue::Log::WARN

module System
  class CommandLineTestCase < SVNx::TestCase
    # init

    def assert_init expecetd, initargs
      cl = System::CommandLine.new initargs
      assert_equal expected, cl.args
    
      def test_init
        assert_init [ "ls" ], [ "ls" ]
      end
    end

    # <<

    def assert_lshift expected, initargs, add
      cl = System::CommandLine.new initargs
      cl << add
      assert_equal expected, cl.args
    end

    def test_lshift
      assert_lshift [ "ls", "/tmp" ], [ "ls" ], "/tmp"
    end

    # to_command

    def assert_to_command expect, args
      cl = System::CommandLine.new args
      assert_equal expect, cl.to_command
    end

    def test_to_command_init
      assert_to_command "ls", [ "ls" ]
    end

    # execute/status

    def assert_execute_status expect_success, args
      cl = System::CommandLine.new args
      cl.execute
      assert_equal expect_success, cl.status.success?, "args: #{args}"
    end

    def test_execute_status_success
      assert_execute_status true, [ "ls", "/tmp" ]
    end

    def test_execute_status_failure
      assert_execute_status false, [ "ls", "/tmpx" ]
    end
  end
end
