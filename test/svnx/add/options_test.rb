#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/add/options'
require 'svnx/options/tc'

module Svnx::Add
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { paths: nil }
      [
        [ { paths: [ "a/b", "c/d" ] }, paths: [ "a/b", "c/d" ] ],
        [ defvals, Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expected, vals|
      assert_send Options, expected, vals
    end    

    param_test [
      [ Array.new,        Hash.new ],
      [ [ "a/b" ],        paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
