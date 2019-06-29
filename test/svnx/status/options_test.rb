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

    def test_paths
      opts = Options.new Hash.new
      assert opts.method :paths
    end

    if true
      param_test [
        { paths: [ "a/b", "c/d" ] },
        { url: "p://a/b" }
      ] do |vals|
        assert_assign vals
      end

      param_test [
        [ Array.new, Hash.new ],
        [ [ "p://abc" ],    url: "p://abc" ],
        [ [ "a/b" ],        paths: [ "a/b" ] ],
        [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
      ] do |exp, vals|
        assert_to_args exp, vals
      end
    end
  end
end
