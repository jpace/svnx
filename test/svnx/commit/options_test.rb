#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/options/tc'

module Svnx::Commit
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { file: nil, paths: nil }
      [
        [ { file: "x/y" } ],
        [ { paths: [ "a/b", "c/d" ] } ],
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
      [ [ "--file", "a/b" ],  file: "a/b" ],
      [ [ "a/b" ],        paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
      [ [ "--with-revprop", "key=value" ], with_revprop: [ "key=value" ] ],
      [ [ "--message", "abc" ], message: [ "abc" ] ],
      [ [ "--username", "name1" ], username: [ "name1" ] ],
      [ [ "--password", "pwd1" ], password: [ "pwd1" ] ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end

    def test_invalid
      assert_raise(RuntimeError) do
        Svnx::Commit::Options.new kabc: "vabc"
      end
    end
  end
end
