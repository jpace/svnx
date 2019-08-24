#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/tc'

module Svnx::Base
  class CommandLineTest < Svnx::TestCase
    params = Array.new.tap do |a|
      a << [ [ "svn", "abc", "--xml" ], CommandLine.new(subcommand: "abc", xml: true) ]
      a << [ [ "svn", "abc" ], CommandLine.new(subcommand: "abc", xml: false) ]
    end

    param_test params do |expected, cmd|
      result = cmd.command
      assert_equal expected, result
    end
  end
end
