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
      assert_options commit: nil, range: nil, accept: nil, path: nil, url: nil
    end

    param_test [
      { commit: 123 },
      { range: "123:456" },
      { accept: "postpone" },
      { path: "a/b" },
      { url: "p://a/b" }
    ].each do |vals|
      assert_assign vals
    end
    
    # to_args

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-c", 123 ], commit: 123 ],
      [ [ "-r", "123:456" ], range: "123:456" ],
      [ [ "--accept", "postpone" ], accept: "postpone" ],
      [ [ "p://abc" ], from: "p://abc" ],
      [ [ "p://abc", "q://def" ], from: "p://abc", url: "q://def" ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: "a/b" ],
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
