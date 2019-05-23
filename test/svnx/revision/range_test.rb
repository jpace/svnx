#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entries'
require 'svnx/revision/range'
require 'svnx/revision/argument'
require 'svnx/tc'
require 'paramesan'

module Svnx::Revision
  class RangeTestCase < Svnx::TestCase
    include Paramesan
    
    # not testing the relative functionality, which is covered by the Argument tests.
    
    def assert_to_s exp, obj, msg
      assert_equal exp, obj.to_s, msg
    end

    param_test [
      [ { from: "1", to: "3",    str: "1:3",    working_copy: false, head: false }, "1:3",           nil ],             
      [ { from: "2", to: "",     str: "2",      working_copy: true,  head: false }, "2",             nil ],             
      [ { from: "4", to: "6",    str: "4:6",    working_copy: false, head: false }, Argument.new(4), Argument.new(6) ], 
      [ { from: "5", to: "HEAD", str: "5:HEAD", working_copy: false, head: true  }, "5",             "HEAD" ],          
    ] do |exp, from, to|
      range = Range.new from, to
      msg = "from: #{from}; to: #{to}"

      assert_to_s  exp[:from],         range.from,          msg
      assert_to_s  exp[:to],           range.to,            msg
      assert_to_s  exp[:str],          range,               msg
      assert_equal exp[:working_copy], range.working_copy?, msg
      assert_equal exp[:head],         range.head?,         msg
    end
  end
end
