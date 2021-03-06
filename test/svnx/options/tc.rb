#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx
  module Options
  end
end

module Svnx::Options
  class TestCase < Svnx::TestCase
    def assert_send optcls, expected, values
      opts = optcls.new values
      expected.each do |methname, expval|
        result = opts.send methname
        assert_equal expval, result
      end
    end
  end
end
