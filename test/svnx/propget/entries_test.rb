#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/entries'
require 'svnx/tc'

module Svnx::Propget
  class EntriesTestCase < Svnx::TestCase
    def assert_entry exppath, expname, expvalue, entry
      assert_equal exppath,  entry.path
      assert_equal expname,  entry.name
      assert_equal expvalue, entry.value
    end

    def test_create_from_xml
      lines = Array.new.tap do |a|
        a << '<?xml version="1.0" encoding="UTF-8"?>'
        a << '<properties>'
        a << '<target'
        a << '   path="/abc">'
        a << '<property'
        a << '   name="svn:ignore">ghi'
        a << 'jkl'
        a << '</property>'
        a << '</target>'
        a << '<target'
        a << '   path="/mno">'
        a << '<property'
        a << '   name="svn:ignore">stuvwx'
        a << '</property>'
        a << '</target>'    
        a << '</properties>'
      end

      entries = Entries.new lines.collect { |line| line + "\n" }
      ary     = entries.to_a
      
      assert_entry "/abc", "svn:ignore", "ghi\njkl\n", ary[0]
      assert_entry "/mno", "svn:ignore", "stuvwx\n",   ary[1]

      assert_equal 2, ary.size
    end
  end
end
