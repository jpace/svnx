#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/strutil'
require 'svnx/tc'

module Svnx
  class StringUtilTest < Svnx::TestCase
    param_test [
      [ "x-y",   "x_y" ],   
      [ "x-y-z", "x_y_z" ], 
      [ "x-y",   :x_y ],    
    ] do |expected, obj|
      result = StringUtil.with_dashes obj
      assert_equal expected, result
    end

    param_test [
      [ "x_y",   "x-y" ], 
      [ "x_y_z", "x-y-z" ]
    ] do |expected, obj|
      result = StringUtil.with_underscores obj
      assert_equal expected, result
    end
  end
end
