#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/status/xml'
require 'common/tc'

module Svnx::Status
  class EntryTestCase < Svnx::TestCase    
    def test_create_from_xml
      x = Entry.new xmlelement: XML::ELEMENTS[1]
      
      assert_equal Svnx::Action.new("modified"), x.status
      assert_equal "a.txt", x.path
      assert_equal "22", x.status_revision
      assert_equal Svnx::Action.new("modified"), x.action
      assert_equal "13", x.commit_revision
      assert_equal "a.txt", x.name

      y = Entry.new xmlelement: XML::ELEMENTS[2]
      
      assert_equal Svnx::Action.new("unversioned"), y.status
      assert_equal "one/two/def.java", y.path
      assert_equal nil, y.status_revision
      assert_equal Svnx::Action.new("unversioned"), y.action
      assert_equal nil, y.commit_revision
      assert_equal "one/two/def.java", y.name
    end
  end
end
