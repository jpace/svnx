#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/args_tc'
require 'svnx/propset/args'

class Svnx::Propset::ArgsTest < Svnx::CommonArgsTestCase
  def create_options optargs = Hash.new
    Svnx::Propset::Options.new optargs
  end

  def create_args options
    Svnx::Propset::Args.new options
  end
  
  def test_default
    assert_to_svn_args Array.new
  end
  
  def test_revision_commit
    assert_to_svn_args [ "-r", "123" ], revision: "123"
  end
  
  def test_revision_range
    assert_to_svn_args [ "-r", "123:456" ], revision: "123:456"
  end
  
  def test_name_value
    assert_to_svn_args [ "abc", "def" ], name: "abc", value: "def"
  end 
  
  def test_value_name
    assert_to_svn_args [ "abc", "def" ], value: "def", name: "abc"
  end 
  
  def test_url
    assert_to_svn_args [ "p://abc" ], url: "p://abc"
  end

  def test_path
    assert_to_svn_args [ "a/b" ], path: "a/b"
  end
end
