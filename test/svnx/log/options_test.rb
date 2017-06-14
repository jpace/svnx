#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/options/tc'

class Svnx::Log::OptionsTest < Svnx::Options::TestCase
  def options_class
    Svnx::Log::Options
  end
  
  def test_assign_default
    defexpected = {
      verbose: nil,
      limit: nil,
      revision: nil,
      path: nil,
      url: nil
    }
    assert_options defexpected
  end

  def test_assign_verbose
    assert_assign verbose: true
  end
  
  def test_assign_limit
    assert_assign limit: 17
  end
  
  def test_assign_revision
    assert_assign revision: 123
  end
  
  def test_assign_paths
    assert_assign path: "a/b"
  end 
  
  def test_assign_url
    assert_assign url: "p://a/b"
  end

  def create_options optargs = Hash.new
    Svnx::Log::Options.new optargs
  end

  def test_to_args_default
    assert_to_args Array.new
  end
  
  def test_to_args_verbose
    assert_to_args [ "-v" ], verbose: true
  end

  def test_to_args_limit
    assert_to_args [ "--limit", 17 ], limit: 17
  end
  
  def test_to_args_revision
    assert_to_args [ "-r123" ], revision: 123
  end
  
  def test_to_args_url
    assert_to_args [ "p://abc" ], url: "p://abc"
  end

  def test_to_args_path
    assert_to_args [ "a/b" ], path: [ "a/b" ]
  end
end
