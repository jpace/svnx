#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'test/unit'

class ObjectUtilTest < Test::Unit::TestCase
  def assert_instance_variables obj, *exp
    exp.each do |name, value|
      result = obj.instance_variable_get name
      assert_equal value, result, "name: #{name}"
    end
  end

  def obj_assigned args, *symbols
    obj = Object.new
    obj.extend Svnx::ObjectUtil
    obj.assign args, symbols
    obj
  end

  def test_assign_one
    obj = obj_assigned({ one: "1" }, :one)
    assert_instance_variables obj, [ "@one", "1" ]
  end
  
  def test_assign_two
    obj = obj_assigned({ one: "1", two: "2" }, :one, :two)
    assert_instance_variables obj, [ "@one", "1" ], [ "@two", "2" ]
  end
  
  def test_assign_ignore
    obj = obj_assigned({ one: "1", two: "2" }, :one)
    assert_instance_variables obj, [ "@one", "1" ], [ "@two", nil ]
  end
end
