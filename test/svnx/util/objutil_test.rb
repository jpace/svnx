#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'test/unit'
require 'paramesan'

class Svnx::ObjectUtilTest < Test::Unit::TestCase
  include Paramesan
  
  param_test [
    [ [ [ "@one", "1" ] ], { one: "1" }, [ :one ] ],
    [ [ [ "@one", "1" ], [ "@two", nil ] ], { one: "1", two: "2" }, [ :one ] ],
    [ [ [ "@one", "1" ], [ "@two", "2" ] ], { one: "1", two: "2" }, [ :one, :two ] ],
  ].each do |expected, args, symbols|
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj.assign args, symbols
    expected.each do |name, value|
      defined = obj.instance_variable_defined? name
      if defined
        result = obj.instance_variable_get name
        assert_equal value, result, "name: #{name}"
      else
        assert_nil value, "name: #{name}"
      end
    end
    puts
  end

  param_test [
  ].each do |expected, args, valid|
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    begin
      obj.validate args, valid
    end
  end
end
