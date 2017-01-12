#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/status/command'
require 'svnx/status/entries'

module Svnx::Status
  class CommandTestCase < Svnx::IntegrationTestCase
    def assert_entry exp_cmt_rev, exp_path, exp_status, exp_st_rev, entries, idx
      entry = entries[idx]
      msg = "entry[#{idx}]: #{entry.path}"

      assert_equal exp_path, entry.path, msg
      assert_equal exp_cmt_rev, entry.commit_revision, msg
      assert_equal exp_status.to_s, entry.status.to_s, msg
      assert_equal exp_st_rev, entry.status_revision, msg
    end

    def test_specified_args
      entries = Svnx::StatusExec.new(path: '/Programs/pvn/pvntestbed.pending', use_cache: false).entries
      
      assert_not_nil entries
      assert_equal 5, entries.size

      sentries = entries.sort { |a, b| a.path <=> b.path }

      assert_entry '13', '/Programs/pvn/pvntestbed.pending/FirstFile.txt', 'modified', '22', sentries, 0
      assert_entry nil, '/Programs/pvn/pvntestbed.pending/SeventhFile.txt', 'added', '-1', sentries, 1
      assert_entry '9', '/Programs/pvn/pvntestbed.pending/dirzero/SixthFile.txt', 'deleted', '22', sentries, 2
      assert_entry nil, '/Programs/pvn/pvntestbed.pending/src/java/Charlie.java', 'unversioned', nil, sentries, 3
      assert_entry nil, '/Programs/pvn/pvntestbed.pending/src/ruby/dog.rb', 'added', '-1', sentries, 4
    end
  end
end
