#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/base/env'

class EnvTest < Test::Unit::TestCase
  def test_default
    env = Svnx::Env.instance
    assert_equal "/tmp/svnx", env.cache_dir_name
    assert_equal "SVNX_TMP_DIR", env.cache_dir_env_varname
    assert_equal "/tmp/svnx", env.cache_dir
  end

  def test_set_env
    origvalue = ENV["SVNX_TMP_DIR"]
    begin
      ENV["SVNX_TMP_DIR"] = "/tmp/abc"
      env = Svnx::Env.instance
      assert_equal "/tmp/svnx", env.cache_dir_name
      assert_equal "SVNX_TMP_DIR", env.cache_dir_env_varname
      assert_equal "/tmp/abc", env.cache_dir
    ensure
      ENV["SVNX_TMP_DIR"] = origvalue
    end
  end

  def test_set_dirname
    env = Svnx::Env.instance
    origvalue = env.cache_dir_name
    begin
      env.cache_dir_name = "/tmp/xyz"
      assert_equal "/tmp/xyz", env.cache_dir_name
      assert_equal "SVNX_TMP_DIR", env.cache_dir_env_varname
      assert_equal "/tmp/xyz", env.cache_dir
    ensure
      env.cache_dir_name = origvalue
    end
  end
end
