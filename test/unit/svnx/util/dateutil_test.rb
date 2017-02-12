#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/dateutil'
require 'test/unit'

class DateUtilTest < Test::Unit::TestCase
  def assert_to_time_units expected, seconds
    result = DateUtil.to_time_units seconds
    assert_equal expected, result, "seconds: #{seconds}"
  end
  
  def test_to_time_units_seconds
    assert_to_time_units "30 seconds", 30
  end
  
  def test_to_time_units_minutes
    assert_to_time_units "15 minutes", 900
  end
  
  def test_to_time_units_hours
    assert_to_time_units "4 hours", 60 * 60 * 4
  end
  
  def test_to_time_units_days
    assert_to_time_units "3 days", 60 * 60 * 24 * 3
  end

  def test_to_time_units_exceeded
    assert_to_time_units nil, 60 * 60 * 24 * 8
  end

  def assert_relative_full expected, frdatestr, todatestr
    fromdate = DateTime.parse(frdatestr).to_time
    todate = DateTime.parse(todatestr).to_time
    result = DateUtil.relative_full fromdate, todate
    assert_equal expected, result, "frdatestr: #{frdatestr}; todatestr: #{todatestr}"
  end

  def test_relative_full_within_bounds
    frdatestr = "2016-10-05 08:36:10 -0400"
    todatestr = "2016-10-08 08:51:40 -0400"
    assert_relative_full "3 days ago (10/05 08:36)", frdatestr, todatestr
  end

  def test_relative_full_exceeds_bounds
    frdatestr = "2016-09-05 08:36:10 -0400"
    todatestr = "2016-10-08 08:51:40 -0400"
    assert_relative_full "2016/09/05 08:36", frdatestr, todatestr
  end

  def assert_fmt_mmdd_hhmm expected, datestr
    date = DateTime.parse datestr
    result = DateUtil.fmt_mmdd_hhmm date
    assert_equal expected, result, "datestr: #{datestr}"
  end

  def test_fmt_mmdd_hhmm
    assert_fmt_mmdd_hhmm "10/05 08:51", "2016-10-05 08:51:10 -0400"
  end
end
