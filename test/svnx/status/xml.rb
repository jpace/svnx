#!/usr/bin/ruby -w
# -*- ruby -*-

require 'nokogiri'

module Svnx::Status
  class XML
    LINES = Array.new.tap do |a|
      a << '<?xml version="1.0"?>'
      a << '<status>'
      a << '  <target'
      a << '      path=".">'
      a << '    <entry'
      a << '        path="a.txt">'
      a << '      <wc-status'
      a << '          props="none"'
      a << '          item="modified"'
      a << '          revision="22">'
      a << '        <commit'
      a << '            revision="13">'
      a << '          <author>authone</author>'
      a << '          <date>2012-09-16T13:51:55.741762Z</date>'
      a << '        </commit>'
      a << '      </wc-status>'
      a << '    </entry>'
      a << '    <entry'
      a << '        path="one/two/def.java">'
      a << '      <wc-status'
      a << '          props="none"'
      a << '          item="unversioned">'
      a << '      </wc-status>'
      a << '    </entry>'
      a << '    <entry'
      a << '        path="one/three/ghi.rb">'
      a << '      <wc-status'
      a << '          props="none"'
      a << '          item="added"'
      a << '          revision="0">'
      a << '      </wc-status>'
      a << '    </entry>'
      a << '    <entry'
      a << '        path="jkl.txt">'
      a << '      <wc-status'
      a << '          props="none"'
      a << '          item="added"'
      a << '          revision="0">'
      a << '      </wc-status>'
      a << '    </entry>'
      a << '    <entry'
      a << '        path="four/mno.txt">'
      a << '      <wc-status'
      a << '          props="none"'
      a << '          item="deleted"'
      a << '          revision="22">'
      a << '        <commit'
      a << '            revision="9">'
      a << '          <author>authtwo</author>'
      a << '          <date>2012-09-16T13:38:01.073277Z</date>'
      a << '        </commit>'
      a << '      </wc-status>'
      a << '    </entry>'
      a << '  </target>'
      a << '</status>'
    end

    # redoc = REXML::Document.new LINES.join('')
    # ELEMENTS = redoc.elements['status'].elements['target'].elements

    nk = Nokogiri::XML LINES.join('')
    ELEMENTS = nk.xpath 'status/target/entry'
  end
end
