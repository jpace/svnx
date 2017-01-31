#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/common/options_tc'

class Svnx::Propget::OptionsTest < Svnx::CommonOptionsTestCase
  def options_class
    Svnx::Propget::Options
  end

  # assign
    
  def test_assign_default
    defexpected = {
      revision: nil,
      revprop: nil,
      url: nil,
      path: nil,
    }
    assert_options defexpected
  end
  
  def test_assign_revision
    assert_assign revision: "123:456"
  end
  
  def test_assign_revprop
    assert_assign revprop: true
  end 
  
  def test_assign_name
    assert_assign name: "abc"
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
  
  def test_to_args_revision_commit
    assert_to_args [ "-r", "123" ], revision: "123"
  end
  
  def test_to_args_revision_range
    assert_to_args [ "-r", "123:456" ], revision: "123:456"
  end
  
  def test_to_args_name
    assert_to_args [ "abc" ], name: "abc"
  end 
  
  def test_to_args_url
    assert_to_args [ "p://abc" ], url: "p://abc"
  end

  def test_to_args_path
    assert_to_args [ "a/b" ], path: "a/b"
  end
end
