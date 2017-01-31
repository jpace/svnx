#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/tc'
require 'svnx/status/entries'

Logue::Log.level = Logue::Log::WARN

module Svnx::Status
  class EntriesTestCase < Svnx::Status::TestCase
    def test_create_from_xml
      xmllines = Array.new

      xmllines << '<?xml version="1.0"?>'
      xmllines << '<status>'
      xmllines << '  <target'
      xmllines << '      path=".">'
      xmllines << '    <entry'
      xmllines << '	path="FirstFile.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="modified"'
      xmllines << '	  revision="22">'
      xmllines << '	<commit'
      xmllines << '	    revision="13">'
      xmllines << '	  <author>Jim</author>'
      xmllines << '	  <date>2012-09-16T13:51:55.741762Z</date>'
      xmllines << '	</commit>'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="src/java/Charlie.java">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="unversioned">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="src/ruby/dog.rb">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="added"'
      xmllines << '	  revision="0">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="SeventhFile.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="added"'
      xmllines << '	  revision="0">'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '    <entry'
      xmllines << '	path="dirzero/SixthFile.txt">'
      xmllines << '      <wc-status'
      xmllines << '	  props="none"'
      xmllines << '	  item="deleted"'
      xmllines << '	  revision="22">'
      xmllines << '	<commit'
      xmllines << '	    revision="9">'
      xmllines << '	  <author>Buddy Bizarre</author>'
      xmllines << '	  <date>2012-09-16T13:38:01.073277Z</date>'
      xmllines << '	</commit>'
      xmllines << '      </wc-status>'
      xmllines << '    </entry>'
      xmllines << '  </target>'
      xmllines << '</status>'
      
      
      entries = Entries.new :xmllines => xmllines
      
      assert_equal 5, entries.size
      assert_status_entry_equals 'modified', 'FirstFile.txt', entries[0]
      assert_status_entry_equals 'unversioned', 'src/java/Charlie.java', entries[1]
      assert_status_entry_equals 'added', 'src/ruby/dog.rb', entries[2]
      assert_status_entry_equals 'added', 'SeventhFile.txt', entries[3]
      assert_status_entry_equals 'deleted', 'dirzero/SixthFile.txt', entries[4]
    end
  end
end
