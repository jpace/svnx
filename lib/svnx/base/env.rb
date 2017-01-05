#!/usr/bin/ruby -w
# -*- ruby -*-

require 'singleton'

module Svnx
end

class Svnx::Env
  include Singleton

  # the directory into which to put cached files
  attr_accessor :cache_dir_name

  # the environment variable, naming the cache directory
  attr_accessor :cache_dir_env_varname
  
  def initialize
    @cache_dir_name = "/tmp/svnx"
    @cache_dir_env_varname = "SVNX_TMP_DIR"
  end

  def cache_dir
    ENV[@cache_dir_env_varname] || @cache_dir_name
  end
end
