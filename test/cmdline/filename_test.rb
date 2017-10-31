#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'cmdline/filename'
require 'paramesan'

module CmdLine
  class FileNameTest < Test::Unit::TestCase
    include Paramesan

    PARAMS = Array.new.tap do |a|
      a << [ "abc.gz",               "abc"            ]
      a << [ "abc-def.gz",           "abc", "def"     ]
      a << [ "abc-def_slash_ghi.gz", "abc", "def/ghi" ]
    end

    param_test PARAMS.each do |exp, *args|
      fn = FileName.new args
      assert_equal exp, fn.name, "args: #{args}"
    end

    param_test PARAMS.each do |exp, *args|
      fn = FileName.new args
      assert_equal exp, fn.to_s, "args: #{args}"
    end
  end
end
