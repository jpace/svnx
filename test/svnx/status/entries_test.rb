#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entries'
require 'svnx/status/xml'
require 'svnx/tc'
require 'paramesan'

module Svnx::Status
  class EntriesTestCase < Svnx::TestCase
    include Paramesan
    
    param_test [
      [ 'modified',    'a.txt',            0 ], 
      [ 'unversioned', 'one/two/def.java', 1 ], 
      [ 'added',       'one/three/ghi.rb', 2 ], 
      [ 'added',       'jkl.txt',          3 ], 
      [ 'deleted',     'four/mno.txt',     4 ], 
    ].each do |expstatus, exppath, idx|
      entries = Entries.new :xmllines => XML::LINES
      entry   = entries[idx]
      assert_equal expstatus.to_s, entry.status.to_s
      assert_equal exppath,        entry.path
    end

    def test_size
      entries = Entries.new :xmllines => XML::LINES
      assert_equal 5, entries.size
    end
  end
end
