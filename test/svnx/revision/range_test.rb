#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/log/entries'
require 'svnx/revision/range'
require 'svnx/revision/argument'
require 'paramesan'

module Svnx::Revision
  class RangeTestCase < Svnx::TestCase
    extend Paramesan
    
    # not testing the relative functionality, which is covered by the Argument tests.
    
    def assert_to_s exp, obj, msg
      assert_equal exp, obj.to_s, msg
    end

    param_test [
      [ { from: "143", to: "199",  str: "143:199",  working_copy: false, head: false }, "143:199", nil ],
      [ { from: "143", to: "",     str: "143",      working_copy: true,  head: false }, "143", nil ],
      [ { from: "143", to: "199",  str: "143:199",  working_copy: false, head: false }, Argument.new(143), Argument.new(199) ],
      [ { from: "143", to: "HEAD", str: "143:HEAD", working_copy: false, head: true  }, "143", "HEAD" ],      
    ].each do |exp, from, to|
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
