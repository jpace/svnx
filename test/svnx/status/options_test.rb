#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/options'
require 'svnx/options/tc'

module Svnx::Status
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      assert_options({ paths: nil, url: nil }, Hash.new)
    end

    param_test [
      { paths: [ "a/b", "c/d" ] },
      { url: "p://a/b" }
    ].each do |vals|
      assert_assign vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
