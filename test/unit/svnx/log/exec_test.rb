#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/log/tc'
require 'svnx/log/exec'

class ExecTest < Test::Unit::TestCase
  def test_equivalent_api
    a = SvnLog::Exec
    b = Svnx::LogExec
    assert_equal b.superclass, a    
  end
end
