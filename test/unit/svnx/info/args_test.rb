#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/args_tc'
require 'svnx/info/args'

class Svnx::Info::ArgsTest < Svnx::CommonArgsTestCase
  def create_options optargs = Hash.new
    Svnx::Info::Options.new optargs
  end

  def create_args options
    Svnx::Info::Args.new options
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
  
  def test_url
    assert_to_svn_args [ "p://abc" ], url: "p://abc"
  end

  def test_path
    assert_to_svn_args [ "a/b" ], path: "a/b"
  end
end
