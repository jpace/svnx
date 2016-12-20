#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'pathname'
require 'svnx/log/line'

class LineTest < Test::Unit::TestCase
  def test_equivalent_api
    a = SvnLog::CommandLine
    b = SVNx::LogCommand
    assert_equal b.superclass, a    
  end
end
