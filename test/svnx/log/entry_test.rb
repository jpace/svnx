#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entry'
require 'svnx/tc'
require 'rexml/document'
require 'nokogiri'

module Svnx::Log
  class EntryTestCase < Svnx::TestCase
    def test_entry
      lines = Array.new.tap do |a|
        a << '<logentry'
        a << '    revision="789">'
        a << '  <author>a-ghi</author>'
        a << '  <date>2019-02-41T41:15:40.132144Z</date>'
        a << '  <msg>ID-2345 - message xyz'
        a << '  </msg>'
        a << '</logentry>'
      end
      
      nk = Nokogiri::XML lines.join('')
      elmt = nk.at_xpath '//logentry'
      
      e = Entry.new elmt
      assert_equal "789",                         e.revision
      assert_equal "a-ghi",                       e.author
      assert_equal nil,                           e.reverse_merge
      assert_equal "2019-02-41T41:15:40.132144Z", e.date
      assert_equal "ID-2345 - message xyz",       e.message.strip
      assert_true e.paths.empty?
      assert_true e.entries.empty?
    end    

    def test_merge_entry
      lines = Array.new.tap do |a|
        a << '  <logentry'
        a << '      revision="567">'
        a << '    <author>a-abc</author>'
        a << '    <date>2019-01-14T14:15:40.321166Z</date>'
        a << '    <msg>ID-1234 Merging from dev to 3.17'
        a << ''
        a << '    </msg>'
        a << '    <logentry'
        a << '	reverse-merge="false"'
        a << '	revision="543">'
        a << '      <author>a-def</author>'
        a << '      <date>2019-01-12T12:41:20.157024Z</date>'
        a << '      <msg>ID-1234 Original message</msg>'
        a << '    </logentry>'
        a << '  </logentry>'
      end
      
      nk = Nokogiri::XML lines.join('')
      elmt = nk.at_xpath '//logentry'
      
      e = Entry.new elmt
      assert_equal "567", e.revision
      assert_equal "a-abc", e.author
      assert_equal nil, e.reverse_merge
      assert_equal "2019-01-14T14:15:40.321166Z", e.date
      assert_equal "ID-1234 Merging from dev to 3.17", e.message.strip
      assert_true e.paths.empty?

      f = e.entries.first
      assert_equal "543", f.revision
      assert_equal "false", f.reverse_merge
      assert_equal "a-def", f.author
      assert_equal "2019-01-12T12:41:20.157024Z", f.date
      assert_equal "ID-1234 Original message", f.message.strip
      assert_true f.paths.empty?
    end
  end
end
