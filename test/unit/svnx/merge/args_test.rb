#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/common/args_tc'
require 'svnx/merge/args'

class TestSvnMergeArgs < SvnCommonArgsTestCase
  def create_options optargs = Hash.new
    SvnMergeOptions.new optargs
  end

  def create_args options
    SvnMergeArgs.new options
  end
  
  def test_default
    assert_to_svn_args Array.new
  end
  
  def test_commit
    assert_to_svn_args [ "-c", 123 ], commit: 123
  end
  
  def test_range
    assert_to_svn_args [ "-r", "123:456" ], range: "123:456"
  end
  
  def test_accept
    assert_to_svn_args [ "--accept", "postpone" ], accept: "postpone"
  end
  
  def test_from
    assert_to_svn_args [ "p://abc" ], from: "p://abc"
  end

  def test_from_url
    assert_to_svn_args [ "p://abc", "q://def" ], from: "p://abc", url: "q://def"
  end
  
  def test_url
    assert_to_svn_args [ "p://abc" ], url: "p://abc"
  end

  def test_path
    assert_to_svn_args [ "a/b" ], path: "a/b"
  end
end
