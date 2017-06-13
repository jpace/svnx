#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

module PathnameAssertions
  def refute_exists pathname
    assert_false pathname.exist?, "pathname: #{pathname}"
  end
 
  def assert_exists pathname
    assert_true pathname.exist?, "pathname: #{pathname}"
  end
end
