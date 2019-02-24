#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/dateutil'
require 'test/unit'
require 'paramesan'

class EnglishTimeTest < Test::Unit::TestCase
  include Paramesan
  
  param_test [
    [ "30 seconds",  30 ],
    [ "119 seconds", 119 ],
    [ "2 minutes",   60 * 2 ],
    [ "15 minutes",  60 * 15 ],
    [ "119 minutes", 60 * 119 ],
    [ "2 hours",     60 * 120 ],
    [ "71 hours",    60 * 60 * 71 ],
    [ "3 days",      60 * 60 * 72 ],
    [ "3 days",      60 * 60 * 24 * 3 ],
    [ nil,           60 * 60 * 24 * 8 ]
  ].each do |exp, seconds|
    result = EnglishTime.new.to_time_units seconds
    assert_equal exp, result, "seconds: #{seconds}"    
  end

  param_test [
    [ "3 days ago (10/05 08:36)", "2016-10-05 08:36:10 -0400", "2016-10-08 08:51:40 -0400" ],
    [ "2016/09/05 08:36",         "2016-09-05 08:36:10 -0400", "2016-10-08 08:51:40 -0400" ]
  ].each do |expected, frdatestr, todatestr|
    fromdate = DateTime.parse(frdatestr).to_time
    todate   = DateTime.parse(todatestr).to_time
    result   = EnglishTime.new.relative_full fromdate, todate
    assert_equal expected, result, "frdatestr: #{frdatestr}; todatestr: #{todatestr}"
  end
end
