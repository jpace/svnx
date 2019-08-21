#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/options'
require 'svnx/options/tc'

module Svnx::Update
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { revision: nil, paths: nil, depth: nil, set_depth: nil }
      [
        [ { revision: nil, paths: nil }, Hash.new ],
        [ { paths: [ "a/b", "c/d" ] },   paths: [ "a/b", "c/d" ] ],
        [ { revision: "123" },           revision: "123" ],
        [ defvals,                       Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expected, vals|
      assert_send Options, expected, vals
    end    

    param_test [
      [ Array.new,                Hash.new ],
      [ [ "-r", "123" ],          revision: "123" ],
      [ [ "a/b" ],                paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ],         paths: [ "a/b", "c/d" ] ],
      [ [ "--ignore-externals" ], ignore_externals: true ],
      [ [ "--depth", "empty" ],   depth: "empty" ],
      [ [ "--set-depth", "empty" ], set_depth: "empty" ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
