#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/options/tc'

module Svnx::Propget
  class OptionsTest < Svnx::Options::TestCase
    def self.build_send_params
      defvals = { revision: nil, revprop: nil, url: nil, path: nil }
      [
        [ { revision: "123:456" } ],
        [ { revprop: true } ],
        [ { name: "abc" } ],
        [ { path: "a/b" } ],
        [ { url: "p://a/b" } ],
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
      [ [ "-r", "123" ],     revision: "123" ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "abc" ],           name: "abc" ],
      [ [ "abc", "p1" ],     name: "abc", path: "p1" ],
      [ [ "p://abc" ],       url: "p://abc" ],
      [ [ "a/b" ],           path: "a/b" ],
    ] do |expected, vals|
      opts = Options.new vals
      assert_equal expected, opts.to_args
    end
  end
end
