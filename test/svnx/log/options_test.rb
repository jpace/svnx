#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/options/tc'

module Svnx::Log
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      defvals = { verbose: nil, limit: nil, revision: nil, path: nil, url: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { verbose:  true },
      { limit:    17 },
      { revision: 123 },
      { path:     "a/b" },
      { url:      "p: //a/b" },
    ] do |vals|
      assert_options vals, vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-v" ], verbose: true ],
      [ [ "--limit", 17 ], limit: 17 ],
      [ [ "-r123" ], revision: 123 ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: [ "a/b" ] ],
    ] do |exp, vals|
      assert_to_args exp, vals
    end

    def test_init
      opts = Svnx::Log::Options.new limit: 17
      assert_equal 17, opts.limit
    end
  end
end
