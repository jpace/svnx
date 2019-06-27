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
      [ "1", "92482", "a5", DateTime.parse("2010-10-05 16:12:09.647500 -0400"), 0 ],
    ].each do |exp_line_number, exp_revision, exp_author, exp_date, idx|
      x = Entry.new XML::ELEMENTS[idx]
      
      assert_equal exp_line_number, x.line_number
      assert_equal exp_revision,    x.revision
      assert_equal exp_author,      x.author
      assert_equal exp_date,        x.datetime
    end
  end
end
