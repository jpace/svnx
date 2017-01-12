#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/tc'
require 'svnx/status/entries'

Logue::Log.level = Logue::Log::WARN

module Svnx::Status
  class EntriesTestCase < Svnx::Status::TestCase
    def test_create_from_xml
      entries = Entries.new :xmllines => Resources::PTP_STATUS.readlines
      info "entries: #{entries}"

      assert_equal 5, entries.size
      assert_status_entry_equals 'modified', 'FirstFile.txt', entries[0]
      assert_status_entry_equals 'unversioned', 'src/java/Charlie.java', entries[1]
      assert_status_entry_equals 'added', 'src/ruby/dog.rb', entries[2]
      assert_status_entry_equals 'added', 'SeventhFile.txt', entries[3]
      assert_status_entry_equals 'deleted', 'dirzero/SixthFile.txt', entries[4]
    end
  end
end
