#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/options/tc'

module Svnx::Diff
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { change:            nil,
                  ignore_properties: nil,
                  ignore_whitespace: nil,
                  paths:             nil,
                  url:               nil }
      [
        [ { change:           123 } ],
        [ { ignore_properties: true } ],
        [ { ignore_properties: false } ],
        [ { ignore_whitespace: true } ],
        [ { ignore_whitespace: false } ],
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
      [ Array.new,                            Hash.new                 ],
      [ [ "--change", 123                  ], change: 123              ],
      [ [ "--ignore-properties"            ], ignore_properties: true  ],
      [ Array.new,                            ignore_properties: false ],
      [ %w{ -x -bw -x --ignore-eol-style },   ignore_whitespace: true  ],
      [ Array.new,                            ignore_whitespace: false ],
      [ [ "p://xyz"                        ], url: "p://xyz"           ],
      [ [ "a/b"                            ], paths: [ "a/b" ]         ],
      [ [ "a/b", "c/d"                     ], paths: [ "a/b", "c/d" ]  ],
      [ [ "--depth", "empty"               ], depth: "empty"           ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
