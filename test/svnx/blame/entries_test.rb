#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/entries'
require 'svnx/blame/xml'
require 'svnx/tc'

module Svnx::Blame
  class EntriesTestCase < Svnx::TestCase
    
    def test_size
      entries = Entries.new XML::LINES
      assert_equal 31, entries.size
    end
  end
end
