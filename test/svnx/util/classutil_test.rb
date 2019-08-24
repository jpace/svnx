#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/classutil'
require 'svnx/tc'

module A1
  class C1
  end
end

module A2
  module B2
    class C2
    end
  end
end

class ClassUtilTest < Svnx::TestCase
  params = Array.new.tap do |a|
    a << [ %w{ A1 },    A1,     A1::C1 ]
    a << [ %w{ A2 B2 }, A2::B2, A2::B2::C2 ]
  end

  param_test params do |expelements, _, cls|
    assert_equal expelements, ClassUtil.module_elements(cls)
  end

  param_test params do |_, expmodule, cls|
    assert_equal expmodule, ClassUtil.find_module(cls)
  end
end
