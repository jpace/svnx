#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/tc'
require 'svnx/info/entries'

class Svnx::Info::EntriesTestCase < Svnx::Info::TestCase
  def assert_info_entry_equals entry, path, kind, revision
    assert_entry_equals entry, :path => path, :kind => 'file', :url => EXPROOT + '/' + path, :root => EXPROOT, :revision => revision
  end

  def test_create_from_xml
    # result of svn info dirzero/SixthFile.txt src/ruby/dog.rb FirstFile.txt:
    
    xmllines = Array.new
    xmllines << '<?xml version="1.0"?>'
    xmllines << '<info>'
    xmllines << '  <entry'
    xmllines << '      kind="file"'
    xmllines << '      path="dirzero/SixthFile.txt"'
    xmllines << '      revision="22">'
    xmllines << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/dirzero/SixthFile.txt</url>'
    xmllines << '    <repository>'
    xmllines << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
    xmllines << '      <uuid>5db1df74-4b47-433d-94f9-36f8fb1c6fd4</uuid>'
    xmllines << '    </repository>'
    xmllines << '    <wc-info>'
    xmllines << '      <schedule>delete</schedule>'
    xmllines << '      <depth>infinity</depth>'
    xmllines << '      <text-updated>2012-09-20T00:20:27.820355Z</text-updated>'
    xmllines << '      <checksum>6f9ca4eac04966649b00af111af0f9fb</checksum>'
    xmllines << '    </wc-info>'
    xmllines << '    <commit'
    xmllines << '	revision="9">'
    xmllines << '      <author>Buddy Bizarre</author>'
    xmllines << '      <date>2012-09-16T13:38:01.073277Z</date>'
    xmllines << '    </commit>'
    xmllines << '  </entry>'
    xmllines << '  <entry'
    xmllines << '      kind="file"'
    xmllines << '      path="src/ruby/dog.rb"'
    xmllines << '      revision="0">'
    xmllines << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/src/ruby/dog.rb</url>'
    xmllines << '    <repository>'
    xmllines << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
    xmllines << '    </repository>'
    xmllines << '    <wc-info>'
    xmllines << '      <schedule>add</schedule>'
    xmllines << '      <depth>infinity</depth>'
    xmllines << '    </wc-info>'
    xmllines << '  </entry>'
    xmllines << '  <entry'
    xmllines << '      kind="file"'
    xmllines << '      path="FirstFile.txt"'
    xmllines << '      revision="22">'
    xmllines << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/FirstFile.txt</url>'
    xmllines << '    <repository>'
    xmllines << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
    xmllines << '      <uuid>5db1df74-4b47-433d-94f9-36f8fb1c6fd4</uuid>'
    xmllines << '    </repository>'
    xmllines << '    <wc-info>'
    xmllines << '      <schedule>normal</schedule>'
    xmllines << '      <depth>infinity</depth>'
    xmllines << '      <text-updated>2012-09-20T00:20:27.820355Z</text-updated>'
    xmllines << '      <checksum>04a26fa6d6b14747191a4dc862d865ff</checksum>'
    xmllines << '    </wc-info>'
    xmllines << '    <commit'
    xmllines << '	revision="13">'
    xmllines << '      <author>Jim</author>'
    xmllines << '      <date>2012-09-16T13:51:55.741762Z</date>'
    xmllines << '    </commit>'
    xmllines << '  </entry>'
    xmllines << '</info>'
    
    entries = Svnx::Info::Entries.new :xmllines => xmllines
    assert_equal 3, entries.size
    
    assert_info_entry_equals entries[0], 'dirzero/SixthFile.txt', 'file', '22'
    assert_info_entry_equals entries[1], 'src/ruby/dog.rb',       'file', '0'
    assert_info_entry_equals entries[2], 'FirstFile.txt',         'file', '22'
  end
end
