#!/usr/bin/ruby -w
# -*- ruby -*-

require 'minitest/autorun'
require 'pathname'
require 'svnx/log/line'

class LineTest < Minitest::Test
  def test_equivalent_api
    a = SvnLog::CommandLine
    b = SVNx::LogCommand
    assert_equal b.superclass, a    
  end
end
