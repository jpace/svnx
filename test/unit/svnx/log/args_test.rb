#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/log/args'

class Svnx::Log::ArgsTest < Test::Unit::TestCase
  include Logue::Loggable
  
  def test_limit
    args = Svnx::Log::Args.new limit: 3
    assert_equal 3, args.limit
  end
end
