#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/tc'
require 'svnx/status/entries'

module Svnx::Status
  class EntriesTestCase < TestCase
    def test_create_from_xml
      xmllines = Array.new

      xmllines << '<?xml version="1.0"?>'
      xmllines << '<status>'
      xmllines << '  <target'
      xmllines << '      path=".">'
      xmllines << '    <entry'
      xmllines << '	path="a.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="modified"'
      xmllines << '	  revision="22">'
      xmllines << '	<commit'
      xmllines << '	    revision="13">'
      xmllines << '	  <author>authone</author>'
      xmllines << '	  <date>2012-09-16T13:51:55.741762Z</date>'
      xmllines << '	</commit>'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="one/two/def.java">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="unversioned">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="one/three/ghi.rb">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="added"'
      xmllines << '	  revision="0">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="jkl.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="added"'
      xmllines << '	  revision="0">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="four/mno.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="deleted"'
      xmllines << '	  revision="22">'
      xmllines << '	<commit'
      xmllines << '	    revision="9">'
      xmllines << '	  <author>authtwo</author>'
      xmllines << '	  <date>2012-09-16T13:38:01.073277Z</date>'
      xmllines << '	</commit>'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '  </target>'
      xmllines << '</status>'
      
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
