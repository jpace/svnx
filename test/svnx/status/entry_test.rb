#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/status/xml'
require 'svnx/tc'

module Svnx::Status
  class EntryTestCase < Svnx::TestCase
    params = Array.new.tap do |a|
      a << [ Svnx::Action::MODIFIED,    "a.txt",            "22", "13", "a.txt",            0 ]
      a << [ Svnx::Action::UNVERSIONED, "one/two/def.java", nil,  nil,  "one/two/def.java", 1 ]
    end

    def get_entry idx, field
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      entry.send field
    end
    
    param_test params do |exp_status, _, _, _, _, idx|
      result = get_entry idx, :status
      assert_equal exp_status, result
    end
    
    param_test params do |_, exp_path, _, _, _, idx|
      result = get_entry idx, :path
      assert_equal exp_path, result
    end
    
    param_test params do |_, _, exp_status_revision, _, _, idx|
      result = get_entry idx, :status_revision
      assert_equal exp_status_revision, result
    end
    
    param_test params do |_, _, _, exp_commit_revision, _, idx|
      result = get_entry idx, :commit_revision
      assert_equal exp_commit_revision, result
    end
    
    param_test params do |_, _, _, _, exp_name, idx|
      result = get_entry idx, :name
      assert_equal exp_name, result
    end
  end
end
