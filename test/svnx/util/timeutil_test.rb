#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/timeutil'
require 'test/unit'
require 'paramesan'

class TimeUtilTest < Test::Unit::TestCase
  include Paramesan
  
  param_test [
    [ [ 30,  :seconds ], 30 ],                
    [ [ 119, :seconds ], 119 ],               
    [ [ 2,   :minutes ], 60 * 2 ],            
    [ [ 15,  :minutes ], 60 * 15 ],           
    [ [ 119, :minutes ], 60 * 119 ],          
    [ [ 2,   :hours ],   60 * 120 ],          
    [ [ 71,  :hours ],   60 * 60 * 71 ],      
    [ [ 3,   :days ],    60 * 60 * 72 ],      
    [ [ 3,   :days ],    60 * 60 * 24 * 3 ],  
    [ [ 14,  :days ],    60 * 60 * 24 * 14 ], 
    [ [ 17,  :days ],    60 * 60 * 24 * 17 ], 
    [ [ 2,   :weeks ],   60 * 60 * 24 * 18 ], 
    [ [ 3,   :weeks ],   60 * 60 * 24 * 22 ], 
    [ [ 8,   :days ],    60 * 60 * 24 * 8 ],  
    [ nil,                60 * 60 * 24 * 30 ], 
  ] do |exp, seconds|
    result = TimeUtil.new.to_units seconds
    assert_equal exp, result, "seconds: #{seconds}"
  end  
end
