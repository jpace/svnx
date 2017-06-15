#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/options/tc'

class Svnx::Commit::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Commit::Options
  end
  
  def test_default
    assert_options file: nil, paths: nil, url: nil
  end

  param_test [
    { file: "x/y" },
    { paths: [ "a/b", "c/d" ] },
    { url: "p://a/b" },
  ].each do |vals|
    assert_assign vals
  end

  param_test [
    [ Array.new, Hash.new ],
    [ [ "-F", "a/b" ], file: "a/b" ],
    [ [ "p://abc" ], url: "p://abc" ],
    [ [ "a/b" ], paths: [ "a/b" ] ],
    [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
  ].each do |exp, vals|
    assert_to_args exp, vals
  end  
end
