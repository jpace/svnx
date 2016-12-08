#!/usr/bin/ruby -w
# -*- ruby -*-

require 'minitest/autorun'
require 'pathname'
require 'svnx/log/tc'
require 'svnx/log/exec'

class ExecTest < Minitest::Test
  def test_equivalent_api
    a = SvnLog::Exec
    b = SVNx::LogExec
    assert_equal b.superclass, a    
  end
end
