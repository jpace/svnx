#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/options/tc'

class Svnx::Propset::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Propset::Options
  end
    
  def test_assign_default
    assert_options file: nil, revision: nil, url: nil, path: nil
  end

  param_test [
    { file: "abc" },
    { revision: "123:456" },
    { name: "abc" },
    { value: "def" },
    { path: "a/b" },
    { url: "p://a/b" },
  ].each do |vals|
    assert_assign vals
  end

  param_test [
    [ Array.new, Hash.new ],
    [ [ "--revprop", "-r", "123" ], revision: "123" ],
    [ [ "--revprop", "-r", "123:456" ], revision: "123:456" ],
    [ [ "abc", "def" ], name: "abc", value: "def" ],
    [ [ "abc", "def" ], value: "def", name: "abc" ],
    [ [ "p://abc" ], url: "p://abc" ],
    [ [ "a/b" ], path: "a/b" ],
    [ [ "abc", "--file", "ghi", "def", ], value: "def", name: "abc", file: "ghi" ],
  ].each do |exp, vals|
    assert_to_args exp, vals
  end
end
