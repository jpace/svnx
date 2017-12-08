#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/entries'
require 'svnx/blame/xml'
require 'svnx/tc'
require 'paramesan'

module Svnx::Blame
  class EntriesTestCase < Svnx::TestCase
    include Paramesan
    
    param_test [
    ].each do |expblame, exppath, idx|
      entries = Entries.new :xmllines => XML::LINES
      entry   = entries[idx]
      assert_equal expblame.to_s, entry.blame.to_s
      assert_equal exppath,        entry.path
    end

    def test_size
      entries = Entries.new :xmllines => XML::LINES
      assert_equal 31, entries.size
    end
  end
end
