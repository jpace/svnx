#!/usr/bin/ruby -w
# -*- ruby -*-

require 'minitest/autorun'
require 'pathname'
require 'svnx/log/args'

class ArgsTest < Minitest::Test
  def test_equivalent_api
    a = SvnLog::Args.new limit: 1
    b = SVNx::LogCmdLine::LogCommandArgs.new limit: 1

    assert_equal b.limit, a.limit
  end
end
