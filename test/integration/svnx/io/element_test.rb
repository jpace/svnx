#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/io/element'

module SVNx::IO
  class ElementTestCase < SVNx::IntegrationTestCase
    def test_init
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      info "el: #{el}"
      assert_equal '/Programs/pvn/pvntestbed.pending', el.local.to_path
    end

    def test_exists
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      info "el: #{el}"
      assert el.exist?
    end

    def test_does_not_exist
      el = Element.new local: '/Programs/pvn/nosuchdirectory'
      info "el: #{el}"
      assert !el.exist?
    end

    def test_is_directory
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/text'
      info "el: #{el}"
      assert el.directory?
    end

    def test_is_not_directory
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/FirstFile.txt'
      info "el: #{el}"
      assert !el.directory?
    end

    def test_get_info_has_info
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/FirstFile.txt'
      inf = el.get_info
      assert_equal 'file', inf.kind
      assert_equal 'FirstFile.txt', inf.path
      assert_equal '22', inf.revision
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from', inf.root
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from/FirstFile.txt', inf.url
    end

    def test_get_info_no_info
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/src/java/Charlie.java'
      assert_nil el.get_info
    end

    def test_is_in_svn_up_to_date
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/src/java/Alpha.java'
      assert el.in_svn?
    end

    def test_is_in_svn_modified
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/FirstFile.java'
      assert el.in_svn?
    end

    def test_not_in_svn
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/src/java/Charlie.java'
      assert !el.in_svn?
    end

    def assert_status_entry exppath, expname, expstatus, entry
      assert_equal exppath, entry.path
      assert_equal expname, entry.name
      assert_equal expstatus, entry.status.to_s
    end

    def test_find_modified_local_entries
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      entries = el.find_modified_entries
      assert_equal 1, entries.size
      assert_status_entry '/Programs/pvn/pvntestbed.pending/FirstFile.txt', '/FirstFile.txt', 'modified', entries[0]
    end

    def assert_log_entry expname, expaction, entry
      assert_equal expname, entry.name
      assert_equal expaction, entry.action.to_s
    end

    def test_find_modified_remote_entries
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      entries = el.find_modified_entries '20:22'
      assert_equal 3, entries.size
      assert_log_entry '/SecondFile.txt', 'modified', entries[0]
      assert_log_entry '/src/ruby/charlie.rb', 'modified', entries[1]
      assert_log_entry '/SecondFile.txt', 'modified', entries[2]
    end
  end
end
