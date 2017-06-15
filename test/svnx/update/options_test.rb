#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/options'
require 'svnx/options/tc'

module Svnx::Update
  class OptionsTest < Svnx::Options::TestCase
    def options_class
      Options
    end

    # assign
    
    def test_assign_default
      defexpected = {
        revision: nil,
        paths: nil,
      }
      assert_options defexpected
    end
    
    def test_assign_revision
      assert_assign revision: 123
    end 
    
    def test_assign_paths
      assert_assign paths: [ "a/b", "c/d" ]
    end 

    # to_args
    
    def test_to_args_default
      assert_to_args Array.new
    end
    
    def test_to_args_revision
      assert_to_args [ "-r", 123 ], revision: 123
    end
    
    def test_to_args_paths_single
      assert_to_args [ "a/b" ], paths: [ "a/b" ]
    end

    def test_to_args_paths_multiple
      assert_to_args [ "a/b", "c/d" ], paths: [ "a/b", "c/d" ]
    end
  end
end
