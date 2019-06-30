#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/options'
require 'svnx/options/tc'

module Svnx::Blame
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { revision: nil, urls: nil, paths: nil }
      [
        [ { revision: "123" } ],
        [ { paths: [ "a/b" ] } ],
        [ { urls: [ "p://a/b" ] } ],
        [ defvals, Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expected, vals|
      assert_send Options, expected, vals
    end    

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-r", "123" ], revision: "123" ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "p://abc" ], urls: [ "p://abc" ] ],
      [ [ "a/b" ], paths: [ "a/b" ] ],
      [ %w{ -x -bw -x --ignore-eol-style }, ignorewhitespace: true ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
