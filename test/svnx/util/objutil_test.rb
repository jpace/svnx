#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'test/unit'
require 'paramesan'

class Svnx::ObjectUtilTest < Test::Unit::TestCase
  include Paramesan

  def self.build_assign_params
    Array.new.tap do |a|
      a << [ [ [ "@one", "1" ] ], { one: "1" }, [ :one ] ]
      a << [ [ [ "@one", "1" ], [ "@two", nil ] ], { one: "1", two: "2" }, [ :one ] ]
      a << [ [ [ "@one", "1" ], [ "@two", "2" ] ], { one: "1", two: "2" }, [ :one, :two ] ]
    end
  end
  
  param_test build_assign_params.each do |expected, args, symbols|
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

  def self.build_validate__params
    obj = Object.new
    obj.extend Svnx::ObjectUtil

    str = String.new
    str.extend Svnx::ObjectUtil
    
    Array.new.tap do |a|
      a << [ nil,                                    obj, { one: "1",   two: "2"             }, [ :one, :two ] ]
      a << [ nil,                                    obj, { one: "1"                         }, [ :one, :two ] ]
      a << [ "invalid field for Object: two",        obj, { one: "1",   two: "2"             }, [ :one       ] ]
      a << [ "invalid field for String: two",        str, { one: "1",   two: "2"             }, [ :one       ] ]
      a << [ "invalid fields for Object: two three", obj, { one: "1",   two: "2", three: "3" }, [ :one       ] ]
    end
  end
  
  param_test build_validate__params.each do |expected, obj, args, valid|
    begin
      result = obj.validate args, valid
      assert_nil expected
      assert_equal true, result
    rescue => e
      assert_equal expected, e.message
    end
  end
end
