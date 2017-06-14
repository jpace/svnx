#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/options'
require 'svnx/options/tc'

class Svnx::Cat::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Cat::Options
  end

  # assign
    
  def test_assign_default
    defexpected = {
      revision: nil,
      url: nil,
      path: nil,
    }
    assert_options defexpected
  end
  
  def test_assign_revision
    assert_assign revision: "123"
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
    # should raise an error here -- cat can't take revision "M:N"
    # assert_to_args [ "-r", "123:456" ], revision: "123:456"
  end
  
  def test_to_args_url
    assert_to_args [ "p://abc" ], url: "p://abc"
  end

  def test_to_args_path
    assert_to_args [ "a/b" ], path: "a/b"
  end
end
