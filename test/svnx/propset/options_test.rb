#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/options/tc'

module Svnx::Propset
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { file: nil, revision: nil, url: nil, path: nil }
      [
        [ { file:     "abc" } ],
        [ { revision: "123: 456" } ],
        [ { name:     "abc" } ],
        [ { value:    "def" } ],
        [ { path:     "a/b" } ],
        [ { url:      "p://a/b" } ],
        [ defvals, Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expected, vals|
      assert_send Options, expected, vals
    end    

    param_test [
      [ Array.new, Hash.new ],
      [ [ "--revprop", "-r", "123" ],     revision: "123" ],
      [ [ "--revprop", "-r", "123:456" ], revision: "123:456" ],
      [ [ "abc", "def" ],                 name: "abc", value: "def" ],
      [ [ "abc", "def" ],                 value: "def", name: "abc" ],
      [ [ "p://abc" ],                    url: "p://abc" ],
      [ [ "a/b" ],                        path: "a/b" ],
      [ [ "abc", "-F", "ghi", "def", ],   value: "def", name: "abc", file: "ghi" ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
