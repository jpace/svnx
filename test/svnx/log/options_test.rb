#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/options/tc'

module Svnx::Log
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { verbose: nil, limit: nil, revision: nil, path: nil, url: nil }      
      [
        [ { verbose:  true } ],
        [ { limit:    17 } ],
        [ { revision: 123 } ],
        [ { path:     "a/b" } ],
        [ { url:      "p: //a/b" } ],
        [ defvals,    Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expvals, vals|
      opts = Options.new vals
      expvals.each do |methname, expval|
        result = opts.send methname
        assert_equal expval, result
      end
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-v" ], verbose: true ],
      [ [ "--limit", 17 ], limit: 17 ],
      [ [ "-r123" ], revision: 123 ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: [ "a/b" ] ],
    ] do |exp, vals|
      opts = Options.new vals
      assert_equal exp, opts.to_args
    end

    def test_init
      opts = Svnx::Log::Options.new limit: 17
      assert_equal 17, opts.limit
    end
  end
end
