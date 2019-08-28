#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/status/xml'
require 'svnx/tc'

module Svnx::Status
  class EntryTestCase < Svnx::TestCase
    params = Array.new.tap do |a|
      a << [ "a.txt",            0 ]
      a << [ "one/two/def.java", 1 ]
    end

    param_test params do |expected, idx|
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      result = entry.path
      assert_equal expected, result
    end

    wc_params = Array.new.tap do |a|
      a << [ "none", Svnx::Action::MODIFIED,     22, 0 ]
      a << [ "none", Svnx::Action::UNVERSIONED, nil, 1 ]
    end
    
    param_test wc_params do |exp_props, exp_status, exp_revision, idx|
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      wc = entry.working_copy
      result = wc.properties
      assert_equal exp_props, result
    end
    
    param_test wc_params do |exp_props, exp_status, exp_revision, idx|
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      wc = entry.working_copy
      result = wc.status
      assert_equal exp_status, result
    end
    
    param_test wc_params do |exp_props, exp_status, exp_revision, idx|
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      wc = entry.working_copy
      result = wc.revision
      assert_equal exp_revision, result
    end

    commit_params = Array.new.tap do |a|
      a << [ "authone", "2012-09-16T13:51:55.741762Z", 13, 0 ]
      a << [ "authtwo", "2012-09-16T13:38:01.073277Z",  9, 4 ]
    end
    
    param_test commit_params do |exp_author, exp_date, exp_revision, idx|
      entry = Entry.new XML::ELEMENTS.to_a[idx]
      commit = entry.working_copy.commit
      result = commit.author
      assert_equal exp_author, result
    end

    def test_no_commit 
      entry = Entry.new XML::ELEMENTS.to_a[1]
      result = entry.working_copy.commit
    end
  end
end
