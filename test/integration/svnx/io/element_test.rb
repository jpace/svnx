#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/io/element'

module SVNx::IO
  class ElementTestCase < SVNx::IntegrationTestCase
    PENDING_PATH = '/Programs/pvn/pvntestbed.pending'
    
    def test_init
      el = Element.new local: PENDING_PATH
      assert_equal PENDING_PATH, el.local.to_path
    end

    def test_exists
      el = Element.new local: PENDING_PATH
      assert el.exist?
    end

    def test_does_not_exist
      el = Element.new local: '/Programs/pvn/nosuchdirectory'
      assert !el.exist?
    end

    def test_is_directory
      el = Element.new local: PENDING_PATH + '/text'
      assert el.directory?
    end

    def test_is_not_directory
      el = Element.new local: PENDING_PATH + '/FirstFile.txt'
      assert !el.directory?
    end

    def test_get_info_has_info
      el = Element.new local: PENDING_PATH + '/FirstFile.txt'
      inf = el.get_info
      assert_equal 'file', inf.kind
      assert_equal 'FirstFile.txt', inf.path
      assert_equal '22', inf.revision
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from', inf.root
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from/FirstFile.txt', inf.url
    end

    def test_get_info_no_info
      el = Element.new local: PENDING_PATH + '/src/java/Charlie.java'
      assert_nil el.get_info
    end

    def test_is_in_svn_up_to_date
      el = Element.new local: PENDING_PATH + '/src/java/Alpha.java'
      assert el.in_svn?
    end

    def test_is_in_svn_modified
      el = Element.new local: PENDING_PATH + '/FirstFile.java'
      assert el.in_svn?
    end

    def test_not_in_svn
      el = Element.new local: PENDING_PATH + '/src/java/Charlie.java'
      assert !el.in_svn?
    end

    def assert_status_entry idx, exp, entries
      entry = entries[idx]
      msg = "entry \##{idx}"      
      assert_equal exp[:path], entry.path, msg
      assert_equal exp[:name], entry.name, msg
      assert_equal exp[:status], entry.status.to_s, msg
    end

    def run_local_test expected, status
      el = Element.new local: PENDING_PATH
      entries = el.find_entries status: status
      assert_equal expected.size, entries.size
      expected.each_with_index do |exp, idx|
        assert_status_entry idx, exp, entries
      end
    end

    def create_status_expected name, status
      { path: PENDING_PATH + name, name: name, status: status }
    end

    def test_find_modified_local_entries
      expected = Array.new
      expected << create_status_expected('/FirstFile.txt', 'modified')
      run_local_test expected, :modified
    end

    def test_find_added_local_entries
      expected = Array.new
      expected << create_status_expected('/SeventhFile.txt', 'added')
      expected << create_status_expected('/src/ruby/dog.rb', 'added')
      run_local_test expected, :added
    end

    def test_find_deleted_local_entries
      expected = Array.new
      expected << create_status_expected('/dirzero/SixthFile.txt', 'deleted')
      run_local_test expected, :deleted
    end

    def test_find_unversioned_local_entries
      expected = Array.new
      expected << create_status_expected('/src/java/Charlie.java', 'unversioned')
      run_local_test expected, :unversioned
    end

    def assert_log_entry expname, expaction, entry
      assert_equal expname, entry.name
      assert_equal expaction, entry.action.to_s
    end

    def test_find_modified_remote_entries
      el = Element.new local: PENDING_PATH
      entries = el.find_entries revision: '20:22', status: :modified
      assert_equal 3, entries.size
      assert_log_entry '/SecondFile.txt', 'modified', entries[0]
      assert_log_entry '/SecondFile.txt', 'modified', entries[1]
      assert_log_entry '/src/ruby/charlie.rb', 'modified', entries[2]
    end

    def assert_paths_equal exppath, path
      assert_equal exppath[:name], path.name
      assert_equal exppath[:action], path.action.to_s
      assert_equal exppath[:kind], path.kind
    end

    def assert_log_entries expected, entries, idx
      msg = "entry \##{idx}"
      assert_equal expected[idx][:author], entries[idx].author, msg
      assert_equal expected[idx][:date], entries[idx].date, msg
      assert_equal expected[idx][:author], entries[idx].author, msg
      assert_equal expected[idx][:revision], entries[idx].revision, msg
      expected[idx][:paths].each_with_index do |exppath, ix|
        assert_paths_equal exppath, entries[idx].paths[ix]
      end
    end
    
    def test_log_entries_no_revision
      el = Element.new local: PENDING_PATH + '/FirstFile.txt'
      # these are entries of entries
      entries = el.log_entries 
      assert_equal 5, entries.size

      expected = Array.new
      expected << { author: 'Jim', 
        date: '2012-09-16T13:51:55.741762Z',
        msg: "We're not sure. Are we...black?",
        revision: '13',
        paths: [ 
                { action: 'modified', kind: 'file', name: '/FirstFile.txt' },
                { action: 'added',    kind: 'file', name: '/SecondFile.txt' }
               ]
      }
      
      assert_log_entries expected, entries, 0

      expected << { author: 'Lyle', 
        date: '2012-09-15T17:30:36.869900Z',
        msg: 'Send wire, main office, tell them I said "ow". Gotcha!',
        revision: '5',
        paths: [ 
                { action: 'modified', kind: 'file', name: '/FirstFile.txt' },
                { action: 'modified', kind: 'file', name: '/SecondFile.txt' }
               ]
      }
      
      assert_log_entries expected, entries, 1
    end
  end
end
