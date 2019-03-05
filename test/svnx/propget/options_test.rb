#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/options/tc'

module Svnx::Propget
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      defvals = { revision: nil, revprop: nil, url: nil, path: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { revision: "123:456" },
      { revprop: true },
      { name: "abc" },
      { path: "a/b" },
      { url: "p://a/b" },
    ] do |vals|
      assert_options vals, vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-r", "123" ],     revision: "123" ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "abc" ],           name: "abc" ],
      [ [ "p://abc" ],       url: "p://abc" ],
      [ [ "a/b" ],           path: "a/b" ],
    ] do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
