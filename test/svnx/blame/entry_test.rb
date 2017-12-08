#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/entry'
require 'svnx/blame/xml'
require 'svnx/tc'
require 'paramesan'

module Svnx::Blame
  class EntryTestCase < Svnx::TestCase
    include Paramesan
    
    param_test [
      [ "1", 92482, "a5", DateTime.parse("2010-10-05 16:12:09.647500 -0400").to_time, 1 ],
    ].each do |exp_line_number, exp_commit_revision, exp_commit_author, exp_commit_date, idx|
      x = Entry.new xmlelement: XML::ELEMENTS[idx]
      
      assert_equal exp_line_number,     x.line_number
      assert_equal exp_commit_revision, x.commit_revision
      assert_equal exp_commit_author,   x.commit_author
      assert_equal exp_commit_date,     x.commit_date
    end
  end
end
