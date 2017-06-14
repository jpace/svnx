#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/options'
require 'svnx/options/tc'
require 'paramesan'

class Svnx::Status::OptionsTest < Svnx::Options::TestCase
  extend Paramesan
  
  def options_class
    Svnx::Status::Options
  end
  
  def test_assign_default
    defexpected = {
      paths: nil,
      url: nil
    }
    assert_options defexpected
  end

  param_test [
    { paths: [ "a/b", "c/d" ] },
    { url: "p://a/b" }
  ].each do |vals|
    assert_assign vals
  end

  param_test [
    [ Array.new, Hash.new ],
    [ [ "p://abc" ], url: "p://abc" ],
    [ [ "a/b" ], paths: [ "a/b" ] ],
    [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
  ].each do |exp, vals|
    assert_to_args exp, vals
  end
end
