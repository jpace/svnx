#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/options'
require 'svnx/options/tc'

module Svnx::Blame
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      defvals = { revision: nil, urls: nil, paths: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { revision: "123" },
      { paths: [ "a/b" ] },
      { urls: [ "p://a/b" ] }
    ].each do |vals|
      assert_options vals, vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-r", "123" ], revision: "123" ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "p://abc" ], urls: [ "p://abc" ] ],
      [ [ "a/b" ], paths: [ "a/b" ] ]
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
