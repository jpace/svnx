#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/status/xml'
require 'svnx/tc'
require 'paramesan'

module Svnx::Status
  class EntryTestCase < Svnx::TestCase
    include Paramesan
    
    param_test [
      [ Svnx::Action.new("modified"),    "a.txt",            "22", Svnx::Action.new("modified"),    "13", "a.txt",            1 ], 
      [ Svnx::Action.new("unversioned"), "one/two/def.java", nil,  Svnx::Action.new("unversioned"), nil,  "one/two/def.java", 2 ]
    ].each do |exp_status, exp_path, exp_status_revision, exp_action, exp_commit_revision, exp_name, idx|
      x = Entry.new xmlelement: XML::ELEMENTS[idx]
      
      assert_equal exp_status, x.status
      assert_equal exp_path, x.path
      assert_equal exp_status_revision, x.status_revision
      assert_equal exp_action, x.action
      assert_equal exp_commit_revision, x.commit_revision
      assert_equal exp_name, x.name
    end
  end
end
