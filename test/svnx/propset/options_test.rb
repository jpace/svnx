#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/options/tc'

module Svnx::Propset
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      defvals = { file: nil, revision: nil, url: nil, path: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { file:     "abc" },
      { revision: "123: 456" },
      { name:     "abc" },
      { value:    "def" },
      { path:     "a/b" },
      { url:      "p://a/b" },
    ].each do |vals|
      assert_options vals, vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "--revprop", "-r", "123" ],       revision: "123" ],
      [ [ "--revprop", "-r", "123:456" ],   revision: "123:456" ],
      [ [ "abc", "def" ],                   name: "abc", value: "def" ],
      [ [ "abc", "def" ],                   value: "def", name: "abc" ],
      [ [ "p://abc" ],                      url: "p://abc" ],
      [ [ "a/b" ],                          path: "a/b" ],
      [ [ "abc", "--file", "ghi", "def", ], value: "def", name: "abc", file: "ghi" ],
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
