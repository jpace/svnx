#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/options/tc'

module Svnx::Log
  class OptionsTest < Svnx::Options::TestCase
    def self.build_init_params
      defvals = { verbose: nil, limit: nil, revision: nil, path: nil, url: nil, stop_on_copy: nil, use_merge_history: nil, depth: nil }
      [
        { verbose:           true },
        { limit:             17 },
        { revision:          123 },
        { path:              "a/b" },
        { url:               "p: //a/b" },
        { stop_on_copy:      true },
        { use_merge_history: true },
        { depth:             "empty" },
        [ defvals, Hash.new ],
      ].collect do |vals|
        if vals.kind_of? Hash
          [ vals, vals ]
        else
          [ vals.first, vals.last ]
        end
      end
    end

    if false
      param_test build_init_params do |expvals, vals|
        opts = Options.new vals
        expvals.each do |methname, expval|
          result = opts.send methname
          assert_equal expval, result
        end
      end
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "--verbose" ], verbose: true ],
      [ [ "--limit", 17 ], limit: 17 ],
      [ [ "-r", 123 ], revision: 123 ],
      [ [ "-r", "HEAD" ], revision: "HEAD" ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: [ "a/b" ] ],
      [ [ "--stop-on-copy" ], stop_on_copy: true ],
      [ [ "--use-merge-history" ], use_merge_history: true ],
      [ [ "--depth", "empty" ], { depth: "empty" } ]
    ] do |exp, vals|
      opts = Options.new vals
      assert_equal exp, opts.to_args
    end
  end
end
