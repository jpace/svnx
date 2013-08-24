#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/log/command'
require 'svnx/log/entries'

module SVNx::Log
  class CommandTestCase < SVNx::IntegrationTestCase
    def assert_entry exp_revision, exp_author, exp_npaths, entries, idx
      assert_equal exp_revision, entries[idx].revision
      assert_equal exp_author, entries[idx].author
      assert_equal exp_npaths, entries[idx].paths.size
    end

    def test_specified_args
      entries = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', revision: nil, limit: nil, verbose: true, use_cache: false).entries
      
      assert_equal 22, entries.size

      assert_entry '21', 'Governor William J. Le Petomane', 3, entries, 1
      assert_entry '1',  'Gabby Johnson', 1, entries, 21
    end

    def test_default_args
      entries = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from').entries

      assert_equal 22, entries.size

      assert_entry '21', 'Governor William J. Le Petomane', 0, entries, 1
      assert_entry '1',  'Gabby Johnson', 0, entries, 21
    end

    def test_non_verbose
      entries = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', verbose: false).entries

      assert_equal 22, entries.size

      assert_entry '21', 'Governor William J. Le Petomane', 0, entries, 1
      assert_entry '1',  'Gabby Johnson', 0, entries, 21
    end

    def test_revision
      entries = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', revision: '1:15').entries

      assert_equal 15, entries.size

      assert_entry '2', 'Harriet Johnson', 0, entries, 1
      assert_entry '15','Mongo', 0, entries, 14
    end

    def test_limit
      entries = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', limit: 5).entries

      assert_equal 5, entries.size

      assert_entry '22', 'Lyle', 0, entries, 0
      assert_entry '18', 'Lili von Shtupp', 0, entries, 4
    end

    def test_default_entries_class
      logexec = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', revision: nil, limit: nil, verbose: true, use_cache: false)
      assert_instance_of SVNx::Log::Entries, logexec.entries
    end

    class LogTestEntries < SVNx::Log::Entries
    end

    def test_specified_entries_class
      logexec = SVNx::LogExec.new(path: '/Programs/pvn/pvntestbed.from', revision: nil, limit: nil, verbose: true, use_cache: false, entries_class: LogTestEntries)
      assert_instance_of LogTestEntries, logexec.entries
    end
  end
end
