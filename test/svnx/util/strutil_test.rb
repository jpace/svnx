#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/strutil'
require 'svnx/tc'

module Svnx
  class StringUtilTest < Svnx::TestCase
    param_test [
      [ "abc-def", "abc_def" ],
      [ "abc-def-ghi", "abc_def_ghi" ],
      [ "abc-def", :abc_def ],
    ] do |expected, obj|
      result = StringUtil.with_dashes obj
      assert_equal expected, result
    end

    param_test [
      [ "abc_def", "abc-def" ],
      [ "abc_def_ghi", "abc-def-ghi" ]
    ] do |expected, obj|
      result = StringUtil.with_underscores obj
      assert_equal expected, result
    end
  end
end
