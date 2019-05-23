#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/options/tc'

module Svnx::Merge
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      defvals = { commit: nil, range: nil, accept: nil, from: nil, to: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { commit: 123 },
      { range:  "123: 456" },
      { accept: "postpone" },
      { from:   "a/b" },
      { to:     "a/b" },
    ] do |vals|
      assert_options vals, vals
    end
    
    # to_args

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-c", 123 ], commit: 123 ],
      [ [ "-r", "123:456" ], range: "123:456" ],
      [ [ "--accept", "postpone" ], accept: "postpone" ],
      [ [ "p://abc" ], from: "p://abc" ],
      [ [ "p://abc", "q://def" ], from: "p://abc", to: "q://def" ],
      [ [ "p://abc" ], from: "p://abc" ],
      [ [ "a/b" ], from: "a/b" ],
    ] do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
