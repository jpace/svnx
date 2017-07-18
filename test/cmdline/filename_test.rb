#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'cmdline/filename'
require 'paramesan'

class CmdLine::FileNameTest < Test::Unit::TestCase
  include Paramesan

  param_test [
    [ "abc.gz",               [ "abc"            ] ],
    [ "abc-def.gz",           [ "abc", "def"     ] ],
    [ "abc-def_slash_ghi.gz", [ "abc", "def/ghi" ] ],
  ].each do |exp, args|
    fn = CmdLine::FileName.new args
    assert_equal exp, fn.name, "args: #{args}"
  end
end
