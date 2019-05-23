#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/options/tc'

module Svnx::Commit
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_default
      defvals = { file: nil, paths: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { file: "x/y" },
      { paths: [ "a/b", "c/d" ] },
    ] do |vals|
      assert_options vals, vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-F", "a/b" ], file: "a/b" ],
      [ [ "a/b" ], paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
    ] do |exp, vals|
      assert_to_args exp, vals
    end

    def test_invalid
      assert_raise(RuntimeError) do
        Svnx::Commit::Options.new kabc: "vabc"
      end
    end
  end
end
