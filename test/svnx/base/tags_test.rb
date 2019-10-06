#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/tags'
require 'svnx/base/fields'
require 'svnx/tc'

module Svnx::Base
  class TagsTest < Svnx::TestCase
    params = Array.new.tap do |a|
      # no == for Procs
      a << [ Proc, :revision ]

      nowstags = %w{ -x -bw -x --ignore-eol-style }
      a << [ nowstags, :ignore_whitespace ]

      a << [ nil, :paths ]
      a << [ nil, :path ]
      a << [ nil, :urls ]
      a << [ nil, :url ]

      a << [ Proc, :file ]

      a << [ RuntimeError, :invalid ]
    end
    
    param_test params do |expected, field|
      if expected == RuntimeError
        assert_raise expected do
          Tags::mapping field
        end
      else
        result = Tags::mapping field
        if expected.kind_of? Class
          assert_kind_of expected, result
        else
          assert_equal expected, result
        end
      end
    end

    class A
      include Tags
      include Fields

      has :revision
    end

    class B
      include Tags
      include Fields

      has :paths
    end

    class C
      include Tags
      include Fields
    end

    params = Array.new.tap do |a|
      a << [ true,  A.new, :revision ]
      a << [ false, A.new, :paths ]
      a << [ false, B.new, :revision ]
      a << [ true,  B.new, :paths ]
    end
    
    param_test params do |expected, obj, field|
      result = obj.fields.has_key? field
      assert_equal expected, result
    end

    def test_no_fields
      result = C.new.fields
      assert_equal Hash.new, result
    end

    params = Array.new.tap do |a|
      a << [ "--abc", :abc ]
      a << [ "--def", :def ]
    end
    
    param_test params do |expected, field|
      result = Tags::to_tag field
      assert_equal expected, result
    end

    class D
      include Tags
      include Fields

      has_tag_field :abc
    end

    params = Array.new.tap do |a|
      a << [ true, :abc ]
      a << [ false, :def ]
    end
    
    param_test params do |expected, field|
      obj = D.new
      result = obj.fields.has_key? field
      assert_equal expected, result
    end

    class E
      include Tags
      include Fields

      has_tag_argument :abc
    end

    params = Array.new.tap do |a|
      a << [ true,  :abc ]
      a << [ false, :def ]
    end
    
    param_test params do |expected, field|
      obj = E.new
      result = obj.fields.has_key? field
      assert_equal expected, result
    end
  end
end
