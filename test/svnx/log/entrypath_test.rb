#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entry'
require 'svnx/tc'
require 'nokogiri'

module Svnx::Log
  class EntryPathTestCase < Svnx::TestCase
    def test_one
      lines = Array.new.tap do |a|
        a << '<paths>'
        a << '<path'
        a << '   action="M"'
        a << '   prop-mods="true"'
        a << '   text-mods="false"'
        a << '   kind="dir">/project/branches/6.1</path>'
        a << '<path'
        a << '   action="M"'
        a << '   prop-mods="false"'
        a << '   text-mods="true"'
        a << '   kind="file">/project/branches/6.1/path/to/file/one.txt</path>'
        a << '</paths>'
        a << '<msg>Update the defrobnicator component with albreutuer.'
        a << '</msg>'
        a << '</logentry>'
      end

      nk = Nokogiri::XML lines.join('')
      elmt = nk.xpath '//paths/path'
      
      p = EntryPath.new attr: elmt[0]

      assert_equal Svnx::Action::MODIFIED, p.action
      assert_equal "dir", p.kind
      assert_equal "/project/branches/6.1", p.name
      assert_true p.prop_mods
      assert_false p.text_mods

      p = EntryPath.new attr: elmt[1]

      assert_equal Svnx::Action::MODIFIED, p.action
      assert_equal "file", p.kind
      assert_equal "/project/branches/6.1/path/to/file/one.txt", p.name
      assert_false p.prop_mods
      assert_true p.text_mods
    end
  end
end
