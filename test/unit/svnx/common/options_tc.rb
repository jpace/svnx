#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'

class Svnx::CommonOptionsTestCase < Test::Unit::TestCase
  def assert_options expvals, optvals = Hash.new
    cls = options_class
    opts = cls.new optvals
    expvals.each do |methname, expval|
      val = opts.send methname
      assert_equal expval, val, "method: #{methname}"
    end
  end
end
