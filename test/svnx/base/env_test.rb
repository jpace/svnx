#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/env'
require 'svnx/tc'

module Svnx
  class EnvTest < Svnx::TestCase
    def assert_env expdirname, expvarname, expcachedir, env
      assert_equal expdirname, env.cache_dir_name
      assert_equal expvarname, env.cache_dir_env_varname
      assert_equal expcachedir, env.cache_dir
    end
    
    def test_default
      env = Svnx::Env.instance
      assert_env "/tmp/svnx", "SVNX_TMP_DIR", "/tmp/svnx", env
    end

    def test_set_env
      origvalue = ENV["SVNX_TMP_DIR"]
      begin
        ENV["SVNX_TMP_DIR"] = "/tmp/abc"
        env = Svnx::Env.instance
        assert_env "/tmp/svnx", "SVNX_TMP_DIR", "/tmp/abc", env
      ensure
        ENV["SVNX_TMP_DIR"] = origvalue
      end
    end

    def test_set_dirname
      env = Svnx::Env.instance
      origvalue = env.cache_dir_name
      begin
        env.cache_dir_name = "/tmp/xyz"
        assert_env"/tmp/xyz", "SVNX_TMP_DIR", "/tmp/xyz", env
      ensure
        env.cache_dir_name = origvalue
      end
    end
  end
end
