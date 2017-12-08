#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/options'
require 'svnx/options/tc'
require 'paramesan'

module Svnx::Update
  class OptionsTest < Svnx::Options::TestCase
    include Paramesan
    
    def options_class
      Options
    end

    param_test [
      [ { revision: nil, paths: nil }, Hash.new ],
      [ { paths: [ "a/b", "c/d" ] },   paths: [ "a/b", "c/d" ] ],
      [ { revision: 123 },             revision: 123 ],
    ].each do |exp, optvals|
      assert_options exp, optvals
    end

    param_test [
      [ Array.new,        Hash.new ],
      [ [ "-r", 123 ],    revision: 123 ],
      [ [ "a/b" ],        paths: [ "a/b" ] ],
      [ [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ] ],
    ].each do |exp, args|
      assert_to_args exp, args
    end
  end
end
