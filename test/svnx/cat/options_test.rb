#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/options'
require 'svnx/options/tc'

module Svnx::Cat
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end
    
    def test_assign_default
      assert_options revision: nil, url: nil, path: nil
    end

    param_test [
      { revision: "123" },
      { path: "a/b" },
      { url: "p://a/b" }
    ].each do |vals|
      assert_assign vals
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-r", "123" ], revision: "123" ],
      # should raise an error here -- cat can't take revision "M:N"
      # [ [ "-r", "123:456" ], revision: "123:456" ],
      [ [ "p://abc" ], url: "p://abc" ],
      [ [ "a/b" ], path: "a/b" ]
    ].each do |exp, vals|
      assert_to_args exp, vals
    end
  end
end
