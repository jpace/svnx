#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'test/unit'
require 'paramesan'

class Svnx::ObjectUtilTest < Test::Unit::TestCase
  include Paramesan

  def self.create_object obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj
  end

  def self.create_string
    create_object String.new
  end

  def self.build_assign_params
    ary1   = [ "@one", "1" ]
    args1  = { one: "1" }
    args12 = args1.merge two: "2"
    
    Array.new.tap do |a|
      a << [ [ ary1                  ], args1,  [ :one       ] ]
      a << [ [ ary1, [ "@two", nil ] ], args12, [ :one       ] ]
      a << [ [ ary1, [ "@two", "2" ] ], args12, [ :one, :two ] ]
    end
  end
  
  param_test build_assign_params.each do |expected, args, symbols|
    obj = self.class.create_object
    obj.assign args, symbols
    expected.each do |name, value|
      msg = "name: #{name}"
      defined = obj.instance_variable_defined? name
      if defined
        result = obj.instance_variable_get name
        assert_equal value, result, msg
      else
        assert_nil value, msg
      end
    end
  end

  def self.build_validate_params
    obj = create_object
    str = create_string

    args1   = { one: "1" }
    args12  = args1.merge two: "2"
    args123 = args12.merge three: "3"
    
    Array.new.tap do |a|
      a << [ nil,                                    obj, args12,  [ :one, :two ] ]
      a << [ nil,                                    obj, args1,   [ :one, :two ] ]
      a << [ "invalid field for Object: two",        obj, args12,  [ :one       ] ]
      a << [ "invalid field for String: two",        str, args12,  [ :one       ] ]
      a << [ "invalid fields for Object: two three", obj, args123, [ :one       ] ]
    end
  end
  
  param_test build_validate_params.each do |expected, obj, args, valid|
    begin
      result = obj.validate args, valid
      assert_nil expected
      assert_equal true, result
    rescue => e
      assert_equal expected, e.message
    end
  end

  class ReadersParamsObject < Object
    include Svnx::ObjectUtil

    attr_readers :rp1, :rp2

    def initialize x, y
      @rp1 = x
      @rp2 = y
    end
  end

  class ReadersArrayObject < Object
    include Svnx::ObjectUtil

    READERS = [ :ra1, :ra2 ]

    attr_readers READERS

    def initialize x, y
      @ra1 = x
      @ra2 = y
    end
  end
  
  def assert_send expected, obj, methname
    begin
      result = obj.send methname
      assert_equal expected, result
    rescue => e
      assert_nil expected, e.message
    end
  end
  
  def self.build_attr_readers_params
    rp = ReadersParamsObject.new "1", "2"
    ra = ReadersArrayObject.new "3", "4"

    Array.new.tap do |a|
      a << [ "1", rp, :rp1 ]
      a << [ "2", rp, :rp2 ]
      a << [ nil, rp, :rp3 ]
      a << [ "3", ra, :ra1 ]
      a << [ "4", ra, :ra2 ]
      a << [ nil, ra, :ra3 ]
    end
  end
  
  param_test build_attr_readers_params.each do |expected, obj, methname|
    assert_send expected, obj, methname
  end
  
  class FieldsParamsObject < Object
    include Svnx::ObjectUtil

    has_fields :fp1, :fp2
  end

  class FieldsArrayObject < Object
    include Svnx::ObjectUtil

    FIELDS = [ :fa1, :fa2 ]

    has_fields FIELDS
  end
  
  def self.build_has_fields_params
    fp = FieldsParamsObject.new fp1: "1", fp2: "2"
    fa = FieldsArrayObject.new fa1: "3", fa2: "4"

    Array.new.tap do |a|
      a << [ "1", fp, :fp1 ]
      a << [ "2", fp, :fp2 ]
      a << [ nil, fp, :fp3 ]
      a << [ "3", fa, :fa1 ]
      a << [ "4", fa, :fa2 ]
      a << [ nil, fa, :fa3 ]
    end
  end
  
  param_test build_has_fields_params.each do |expected, obj, methname|
    assert_send expected, obj, methname
  end

  def self.build_create_invalid_fields_message_params
    obj = create_object
    str = create_string

    Array.new.tap do |a|
      a << [ "invalid field for Object: one",        obj, [ :one       ] ]
      a << [ "invalid field for Object: two",        obj, [ :two       ] ]
      a << [ "invalid field for String: two",        str, [ :two       ] ]
      a << [ "invalid fields for Object: two three", obj, [ :two, :three ] ]
    end
  end
  
  param_test build_create_invalid_fields_message_params.each do |expected, obj, fields|
    result = obj.create_invalid_fields_message fields
    assert_equal expected, result
  end
end
