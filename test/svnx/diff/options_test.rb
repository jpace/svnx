#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/options/tc'
require 'paramesan'

module Svnx::Diff
  class OptionsTest < Svnx::Options::TestCase
    include Paramesan
    
    def options_class
      Options
    end

    param_test [
      # default:
      { commit:           nil,
        ignoreproperties: nil,
        ignorewhitespace: nil,
        paths:            nil,
        url:              nil },
      { commit:           123 },
      { ignoreproperties: true },
      { ignoreproperties: false },
      { ignorewhitespace: true },
      { ignorewhitespace: false },
    ].each do |vals|
      assert_options vals, vals
    end

    param_test [
      [ { url: "p://xyz", paths: nil }, url: "p://xyz" ],
      [ { paths: [ "a/b" ], url: nil }, paths: [ "a/b" ] ],
    ].each do |exp, optvals|
      assert_options exp, optvals
    end

    param_test [
      [ Array.new,                            Hash.new                ],
      [ [ "-c", 123                        ], commit: 123             ],
      [ [ "--ignore-properties"            ], ignoreproperties: true  ],
      [ Array.new,                            ignoreproperties: false ],
      [ [ "-x", "-bw"                      ], ignorewhitespace: true  ],
      [ Array.new,                            ignorewhitespace: false ],
      [ [ "p://xyz"                        ], url: "p://xyz"          ],
      [ [ "a/b"                            ], paths: [ "a/b" ]        ],
      [ [ "a/b", "c/d"                     ], paths: [ "a/b", "c/d" ] ],
      [ [ "--depth", "empty"               ], depth: "empty"          ],
    ].each do |exp, optvals|
      assert_to_args exp, optvals
    end
  end
end
