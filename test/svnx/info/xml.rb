#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'nokogiri'

module Svnx
  module Info
  end
end

module Svnx::Info
  class XML
    # result of svn info dirzero/SixthFile.txt src/ruby/dog.rb FirstFile.txt:
    
    LINES = Array.new.tap do |a|
      a << '<?xml version="1.0"?>'
      a << '<info>'
      a << '  <entry'
      a << '      kind="file"'
      a << '      path="dirzero/SixthFile.txt"'
      a << '      revision="22">'
      a << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/dirzero/SixthFile.txt</url>'
      a << '    <repository>'
      a << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
      a << '      <uuid>5db1df74-4b47-433d-94f9-36f8fb1c6fd4</uuid>'
      a << '    </repository>'
      a << '    <wc-info>'
      a << '      <schedule>delete</schedule>'
      a << '      <depth>infinity</depth>'
      a << '      <text-updated>2012-09-20T00:20:27.820355Z</text-updated>'
      a << '      <checksum>6f9ca4eac04966649b00af111af0f9fb</checksum>'
      a << '    </wc-info>'
      a << '    <commit'
      a << '	revision="9">'
      a << '      <author>Buddy Bizarre</author>'
      a << '      <date>2012-09-16T13:38:01.073277Z</date>'
      a << '    </commit>'
      a << '  </entry>'
      a << '  <entry'
      a << '      kind="file"'
      a << '      path="src/ruby/dog.rb"'
      a << '      revision="0">'
      a << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/src/ruby/dog.rb</url>'
      a << '    <repository>'
      a << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
      a << '    </repository>'
      a << '    <wc-info>'
      a << '      <schedule>add</schedule>'
      a << '      <depth>infinity</depth>'
      a << '    </wc-info>'
      a << '  </entry>'
      a << '  <entry'
      a << '      kind="file"'
      a << '      path="FirstFile.txt"'
      a << '      revision="22">'
      a << '    <url>file:///Programs/Subversion/Repositories/pvntestbed.from/FirstFile.txt</url>'
      a << '    <repository>'
      a << '      <root>file:///Programs/Subversion/Repositories/pvntestbed.from</root>'
      a << '      <uuid>5db1df74-4b47-433d-94f9-36f8fb1c6fd4</uuid>'
      a << '    </repository>'
      a << '    <wc-info>'
      a << '      <schedule>normal</schedule>'
      a << '      <depth>infinity</depth>'
      a << '      <text-updated>2012-09-20T00:20:27.820355Z</text-updated>'
      a << '      <checksum>04a26fa6d6b14747191a4dc862d865ff</checksum>'
      a << '    </wc-info>'
      a << '    <commit'
      a << '	revision="13">'
      a << '      <author>Jim</author>'
      a << '      <date>2012-09-16T13:51:55.741762Z</date>'
      a << '    </commit>'
      a << '  </entry>'
      a << '</info>'
    end

    doc = REXML::Document.new LINES.join('')
    ELEMENTS = doc.elements[1]

    NOKOGIRI_ELEMENTS = Nokogiri::XML LINES.join('')
  end
end
