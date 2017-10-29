#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/options/tc'

module Svnx::Propget
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      assert_options revision: nil, revprop: nil, url: nil, path: nil
    end

    param_test [
      { revision: "123:456" },
      { revprop: true },
      { name: "abc" },
      { path: "a/b" },
      { url: "p://a/b" },
    ].each do |vals|
      assert_assign vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-r", "123" ], revision: "123" ],
      [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "abc" ], name: "abc" ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: "a/b" ],
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
