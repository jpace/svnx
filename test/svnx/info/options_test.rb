#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/options/tc'

module Svnx::Info
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end

    # assign
    
    def test_assign_default
      defvals = { revision: nil, url: nil, path: nil }
      assert_options defvals, Hash.new
    end

    param_test [
      { revision: "123" },
      { path:     "a/b" },
      { url:      "p: //a/b" }
    ].each do |vals|
      assert_options vals, vals
    end

    param_test [
      [ [                 ], Hash.new            ],
      [ [ "-r", "123"     ], revision: "123"     ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "p://abc"       ], url: "p://abc"      ],
      [ [ "a/b"           ], path: "a/b"         ]
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
