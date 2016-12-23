#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/log/args'

class ArgsTest < Test::Unit::TestCase
  include Logue::Loggable
  
  def test_equivalent_api
    a = SvnLog::Args.new limit: 1
    b = SVNx::LogCmdLine::LogCommandArgs.new limit: 1
    assert_equal b.limit, a.limit
  end

  def test_limit
    args = SvnLog::Args.new limit: 3
    assert_equal 3, args.limit
  end
end
