#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/revision/date'
require 'time'

module Svnx::Revision
  class DateTest < Test::Unit::TestCase
    # to_svn_str

    def assert_to_svn_str expected, frdatestr, todatestr
      fromdate = DateTime.parse(frdatestr).to_time
      todate = DateTime.parse(todatestr).to_time
      dtdt = DateToDate.new fromdate, todate
      result = dtdt.to_svn_str
      assert_equal expected, result, "frdatestr: #{frdatestr}; todatestr: #{todatestr}"
    end

    def test_to_svn_str_default
      frdatestr = "2016-10-05 08:36:10 -0400"
      todatestr = "2016-10-08 08:51:40 -0400"
      assert_to_svn_str "{2016-10-05}:{2016-10-08}", frdatestr, todatestr
    end  
  end
end
