#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/options/tc'

module Svnx::Diff
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { commit:           nil,
                  ignoreproperties: nil,
                  ignorewhitespace: nil,
                  paths:            nil,
                  url:              nil }
      [
        [ { commit:           123 } ],
        [ { ignoreproperties: true } ],
        [ { ignoreproperties: false } ],
        [ { ignorewhitespace: true } ],
        [ { ignorewhitespace: false } ],
        [ { url: "p://xyz", paths: nil }, url: "p://xyz" ],
        [ { paths: [ "a/b" ], url: nil }, paths: [ "a/b" ] ],
        [ defvals, Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expected, vals|
      assert_send Options, expected, vals
    end    

    param_test [
      [ Array.new,                            Hash.new                ],
      [ [ "-c", 123                        ], commit: 123             ],
      [ [ "--ignore-properties"            ], ignoreproperties: true  ],
      [ Array.new,                            ignoreproperties: false ],
      [ %w{ -x -bw -x --ignore-eol-style },   ignorewhitespace: true  ],
      [ Array.new,                            ignorewhitespace: false ],
      [ [ "p://xyz"                        ], url: "p://xyz"          ],
      [ [ "a/b"                            ], paths: [ "a/b" ]        ],
      [ [ "a/b", "c/d"                     ], paths: [ "a/b", "c/d" ] ],
      [ [ "--depth", "empty"               ], depth: "empty"          ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
