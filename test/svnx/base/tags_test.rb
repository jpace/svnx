#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/tags'
require 'svnx/base/fields'
require 'svnx/tc'

module Svnx::Base
  class TagsTest < Svnx::TestCase
    def self.create_object obj = Object.new
      obj.extend Svnx::Base::Tags
      obj
    end

    params = Array.new.tap do |a|
      # no == for Procs
      a << [ Proc, :revision ]

      nowstags = %w{ -x -bw -x --ignore-eol-style }
      a << [ nowstags, :ignorewhitespace ]
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
          Svnx::Base::Tags::mapping field
        end
      else
        result = Svnx::Base::Tags::mapping field
        if expected.kind_of? Class
          assert_kind_of expected, result
        else
          assert_equal expected, result
        end
      end
    end

    class A
      include Svnx::Base::Tags
      include Svnx::Base::Fields

      has :revision
    end

    class B
      include Svnx::Base::Tags
      include Svnx::Base::Fields

      has :paths
    end

    class C
      include Svnx::Base::Tags
      include Svnx::Base::Fields
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
      assert_false result
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
      include Svnx::Base::Tags
      include Svnx::Base::Fields

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
  end
end
