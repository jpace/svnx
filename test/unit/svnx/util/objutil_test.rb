#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'test/unit'

class ObjectUtilTest < Test::Unit::TestCase
  def assert_instance_variable exp, obj, name
    val = obj.instance_variable_get name
    assert_equal exp, val, "name: #{name}"
  end
  
  def test_assign_one
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj.assign({ one: "1" }, :one)
    assert_instance_variable "1", obj, "@one"
  end
  
  def test_assign_two
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj.assign({ one: "1", two: "2" }, :one, :two)
    assert_instance_variable "1", obj, "@one"
    assert_instance_variable "2", obj, "@two"
  end
  
  def test_assign_ignore
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj.assign({ one: "1", two: "2" }, :one)
    assert_instance_variable "1", obj, "@one"
    assert_instance_variable nil, obj, "@two"
  end
end
