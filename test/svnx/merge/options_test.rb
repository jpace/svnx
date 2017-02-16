#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/options_tc'
require 'svnx/merge/options'

class Svnx::Merge::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Merge::Options
  end

  # assign
  
  def test_assign_default
    defexpected = {
      commit: nil,
      range: nil,
      accept: nil,
      path: nil,
      url: nil
    }
    assert_options defexpected
  end
  
  def test_assign_commit
    assert_assign commit: 123
  end
  
  def test_assign_range
    assert_assign range: "123:456"
  end
  
  def test_assign_accept
    assert_assign accept: "postpone"
  end 
  
  def test_assign_path
    assert_assign path: "a/b"
  end 
  
  def test_assign_url
    assert_assign url: "p://a/b"
  end

  # to_args
  
  def test_to_args_default
    assert_to_args Array.new
  end
  
  def test_to_args_commit
    assert_to_args [ "-c", 123 ], commit: 123
  end
  
  def test_to_args_range
    assert_to_args [ "-r", "123:456" ], range: "123:456"
  end
  
  def test_to_args_accept
    assert_to_args [ "--accept", "postpone" ], accept: "postpone"
  end
  
  def test_to_args_from
    assert_to_args [ "p://abc" ], from: "p://abc"
  end

  def test_to_args_from_url
    assert_to_args [ "p://abc", "q://def" ], from: "p://abc", url: "q://def"
  end
  
  def test_to_args_url
    assert_to_args [ "p://abc" ], url: "p://abc"
  end

  def test_to_args_path
    assert_to_args [ "a/b" ], path: "a/b"
  end
end
