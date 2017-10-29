#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entry'
require 'svnx/log/xml'
require 'svnx/tc'

module Svnx::Log
  class EntryTestCase < Svnx::TestCase
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
    
    def test_entry_from_xml
      entry = Entry.new :xmlelement => XML::ELEMENTS.elements[4]

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
  end
end
