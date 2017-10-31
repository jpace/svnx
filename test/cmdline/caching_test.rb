#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/caching'
require 'cmdline/tc'

# Ruby 2 changes this to "file: Class#method", so we've got to cache it (ironic, no?)
$curfile = $0

module CmdLine
  class TestingCachingCommandLine < CachingCommandLine
    def cache_dir
      CommandTestCase::CACHE_DIR.to_s
    end
  end
  
  class CachingCommandLineTestCase < CommandTestCase
    def create_command_line args = %w{ ls /bin }
      CachingCommandLine.new(*args)
    end

    def create_testing_command_line args = %w{ ls /bin }
      TestingCachingCommandLine.new(*args)
    end

    def test_cache_dir_defaults_to_executable
      cl = create_command_line
      exp = '/tmp' + (Pathname.new($curfile).expand_path).to_s
      assert_equal exp, cl.cache_dir
    end

    def test_cache_file_defaults_to_executable
      cl = create_command_line
      exp = '/tmp' + (Pathname.new($curfile).expand_path).to_s + '/ls-_slash_bin.gz'
      assert_equal exp, cl.cache_file.to_s
    end

    def test_cache_dir_set_cachefile
      cl = create_testing_command_line
      
      assert_not_nil cl.cache_dir
      assert_false CACHE_DIR.exist?

      cachefile = cl.cache_file
      assert_equal CACHE_DIR.to_s + '/ls-_slash_bin.gz', cachefile.to_s
    end

    def test_cache_dir_created_on_execute
      cl = create_testing_command_line

      cachefile = cl.cache_file

      cl.execute
      assert CACHE_DIR.exist?
      cachelines = read_gzfile cachefile

      # we can't use /tmp, since this test will add to it:
      syslines = IO.popen("ls /bin") do |io|
        io.readlines
      end
      
      assert_equal syslines, cachelines
    end

    def test_cache_file_matches_results
      dir = "/usr/local/bin"
      cl = create_testing_command_line [ "ls", dir ]
      
      cachefile = cl.cache_file

      cl.execute
      assert CACHE_DIR.exist?, "CACHE_DIR: #{CACHE_DIR}"

      cachelines = read_gzfile cachefile

      syslines = IO.popen("ls #{dir}") do |io|
        io.readlines
      end

      assert_equal syslines, cachelines
    end
  end
end
