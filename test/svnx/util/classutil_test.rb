#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/classutil'
require 'svnx/tc'
require 'paramesan'

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
  include Paramesan
  
  def self.build_params
    Array.new.tap do |a|
      a << [ %w{ A1 },    A1,     A1::C1 ]
      a << [ %w{ A2 B2 }, A2::B2, A2::B2::C2 ]
    end
  end

  param_test build_params do |expelements, expmodule, cls|
    assert_equal expelements, ClassUtil.module_elements(cls)
  end

  param_test build_params do |expelements, expmodule, cls|
    assert_equal expmodule, ClassUtil.find_module(cls)
  end
end
