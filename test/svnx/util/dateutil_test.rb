#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/dateutil'
require 'test/unit'
require 'paramesan'

class DateUtilTest < Test::Unit::TestCase
  include Paramesan

  param_test [
    [ "10/05 08:51", "2016-10-05 08:51:10 -0400" ],
    [ "10/05 08:54", "2016-10-05 08:54:10 -0400" ],
    [ "10/06 08:54", "2016-10-06 08:54:10 -0400" ],
  ] do |expected, datestr|
    date   = DateTime.parse datestr
    result = DateUtil.fmt_mmdd_hhmm date
    assert_equal expected, result
  end
end
