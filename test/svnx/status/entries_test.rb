#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/tc'
require 'svnx/status/entries'

module Svnx::Status
  class EntriesTestCase < TestCase
    def test_create_from_xml
      xmllines = Array.new.tap do |a|
        a << '<?xml version="1.0"?>'
        a << '<status>'
        a << '  <target'
        a << '      path=".">'
        a << '    <entry'
        a << '	path="a.txt">'
        a << '      <wc-status'
        a << '	  props="none"'
        a << '	  item="modified"'
        a << '	  revision="22">'
        a << '	<commit'
        a << '	    revision="13">'
        a << '	  <author>authone</author>'
        a << '	  <date>2012-09-16T13:51:55.741762Z</date>'
        a << '	</commit>'
        a << '      </wc-status>'
        a << '    </entry>'
        a << '    <entry'
        a << '	path="one/two/def.java">'
        a << '      <wc-status'
        a << '	  props="none"'
        a << '	  item="unversioned">'
        a << '      </wc-status>'
        a << '    </entry>'
        a << '    <entry'
        a << '	path="one/three/ghi.rb">'
        a << '      <wc-status'
        a << '	  props="none"'
        a << '	  item="added"'
        a << '	  revision="0">'
        a << '      </wc-status>'
        a << '    </entry>'
        a << '    <entry'
        a << '	path="jkl.txt">'
        a << '      <wc-status'
        a << '	  props="none"'
        a << '	  item="added"'
        a << '	  revision="0">'
        a << '      </wc-status>'
        a << '    </entry>'
        a << '    <entry'
        a << '	path="four/mno.txt">'
        a << '      <wc-status'
        a << '	  props="none"'
        a << '	  item="deleted"'
        a << '	  revision="22">'
        a << '	<commit'
        a << '	    revision="9">'
        a << '	  <author>authtwo</author>'
        a << '	  <date>2012-09-16T13:38:01.073277Z</date>'
        a << '	</commit>'
        a << '      </wc-status>'
        a << '    </entry>'
        a << '  </target>'
        a << '</status>'
      end
      
      entries = Entries.new :xmllines => xmllines
      
      assert_equal 5, entries.size
      assert_status_entry_equals 'modified', 'a.txt', entries[0]
      assert_status_entry_equals 'unversioned', 'one/two/def.java', entries[1]
      assert_status_entry_equals 'added', 'one/three/ghi.rb', entries[2]
      assert_status_entry_equals 'added', 'jkl.txt', entries[3]
      assert_status_entry_equals 'deleted', 'four/mno.txt', entries[4]
    end
  end
end
