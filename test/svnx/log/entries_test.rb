#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entries'
require 'svnx/log/xml'
require 'svnx/tc'

module Svnx::Log
  class EntriesTestCase < Svnx::Common::TestCase
    def assert_log_entry_equals expdata, entry
      assert_equal expdata[0], entry.revision
      assert_equal expdata[1], entry.author
      assert_equal expdata[2], entry.date
      assert_equal expdata[3], entry.message
      entry.paths.each_with_index do |path, idx|
        assert_equal expdata[4 + idx][:kind], path.kind
        assert_equal expdata[4 + idx][:action], path.action
        assert_equal expdata[4 + idx][:name], path.name
      end
    end
    
    def assert_entry_fields_not_nil entry
      # these are occasionally missing or blank, which REXML considers nil:
      assert entry.message
      assert entry.author
    end

    def assert_log_entry_16 entry
      expdata = '16', 'Buddy Bizarre', '2012-09-16T14:07:30.329525Z', 'CUT! What in the hell do you think you\'re doing here? This is a closed set.'
      expdata << { :kind => 'dir', 
        :action => 'A', 
        :name => '/src/java'
      }
      expdata << { :kind => 'file', 
        :action => 'A', 
        :name => '/src/java/Alpha.java'
      }
      expdata << { :kind => 'file', 
        :action => 'A', 
        :name => '/src/java/Bravo.java'
      }
      
      assert_log_entry_equals expdata, entry
    end
    
    def test_create_from_xml
      # doing "svn log -r19:5"
      entries = Entries.new xmllines: XML::LINES
      puts "entries: #{entries}"
      assert_log_entry_16 entries[3]
    end
    
    def test_empty_message_element
      lines = Array.new.tap do |a|
        a << '<?xml version="1.0"?>'
        a << '<log>'
        a << '<logentry'
        a << '   revision="19">'
        a << '<author>Lili von Shtupp</author>'
        a << '<date>2012-09-16T14:24:07.913759Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '</log>'
      end
      
      entries = Entries.new :xmllines => lines
      info "entries: #{entries}"
      
      # empty message here:
      assert_entry_fields_not_nil entries[0]
    end

    def test_create_on_demand
      # although entries now supports xmllines as an Array, we need the size for the assertion:
      xmllines = XML::LINES
      
      assert_equal 101, xmllines.size

      entries = Entries.new :xmllines => xmllines

      nentries = entries.size
      assert_equal 15, nentries

      # the power of Ruby, effortlessly getting instance variables ...

      real_entries = entries.instance_eval '@entries'

      # nothing processed yet ...
      assert_nil real_entries[12]
      assert_nil real_entries[13]
      assert_nil real_entries[14]

      assert_entry_fields_not_nil entries[13]

      # and these still aren't processed:
      assert_nil real_entries[12]
      assert_nil real_entries[14]
    end

    def test_each
      idx = 0

      entries = Entries.new :xmllines => XML::LINES
      entries.each do |entry|
        if idx == 3
          assert_log_entry_16 entry
        end
        idx += 1
      end
    end
  end
end
