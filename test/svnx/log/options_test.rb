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
      assert_options verbose: nil, limit: nil, revision: nil, path: nil, url: nil
    end

    param_test [
      { verbose: true },
      { limit: 17 },
      { revision: 123 },
      { path: "a/b" },
      { url: "p://a/b" },
    ].each do |vals|
      assert_assign vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-v" ], verbose: true ],
      [ [ "--limit", 17 ], limit: 17 ],
      [ [ "-r123" ], revision: 123 ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: [ "a/b" ] ],
    ].each do |exp, vals|
      assert_to_args exp, vals
    end    
  end
end
