#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/entries'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Propget::EntriesTestCase < Svnx::Common::TestCase
  def assert_entry exppath, expname, expvalue, entry
    assert_equal exppath, entry.path
    assert_equal expname, entry.name
    assert_equal expvalue, entry.value
  end

  def test_create_from_xml
    lines = Array.new
    lines << '<?xml version="1.0" encoding="UTF-8"?>'
    lines << '<properties>'
    lines << '<target'
    lines << '   path="/abc">'
    lines << '<property'
    lines << '   name="svn:ignore">ghi'
    lines << 'jkl'
    lines << '</property>'
    lines << '</target>'
    lines << '<target'
    lines << '   path="/mno">'
    lines << '<property'
    lines << '   name="svn:ignore">stuvwx'
    lines << '</property>'
    lines << '</target>'    
    lines << '</properties>'

    entries = Svnx::Propget::Entries.new xmllines: lines.collect { |line| line + "\n" }.join
    ary = entries.to_a
    
    assert_entry "/abc", "svn:ignore", "ghi\njkl\n", ary[0]
    assert_entry "/mno", "svn:ignore", "stuvwx\n", ary[1]

    assert_equal 2, ary.size
  end
end
