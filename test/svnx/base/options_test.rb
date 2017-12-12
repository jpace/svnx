#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'
require 'test/unit'
require 'paramesan'

module Svnx::Base
  class ExampleOptions < Options
    attr_reader :m1, :m2
    
    def initialize m1, m2
      @m1 = m1
      @m2 = m2
    end
    
    def options_to_args
      [ [ :m1, [ "v1" ] ], [ :m2, [ "v2a", "v2b" ] ] ]
    end
  end
  
  class OptionsTest < Test::Unit::TestCase
    include Paramesan
    
    def test_init
      Options.new
    end

    param_test [
      [ %w{ v1 },         true,  false ], 
      [ %w{ v2a v2b },    false, true ],  
      [ %w{ v1 v2a v2b }, true,  true ],  
    ].each do |expected, m1, m2|
      opts = ExampleOptions.new m1, m2
      args = opts.to_args
      assert_equal expected, args, "m1: #{m1}; m2: #{m2}"
    end
  end
end  
