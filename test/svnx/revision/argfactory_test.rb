#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'
require 'svnx/log/entries'
require 'svnx/revision/argument'
require 'svnx/tc'

module Svnx::Revision
  class ArgumentFactoryTestCase < Svnx::TestCase
    def setup
      lines = Array.new.tap do |a|
        a << '<?xml version="1.0"?>'
        a << '<log>'
        a << '<logentry'
        a << '   revision="22">'
        a << '<author>Lyle</author>'
        a << '<date>2012-09-18T11:32:19.542597Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '<logentry'
        a << '   revision="20">'
        a << '<author>Howard Johnson</author>'
        a << '<date>2012-09-18T11:28:08.481016Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '<logentry'
        a << '   revision="19">'
        a << '<author>Lili von Shtupp</author>'
        a << '<date>2012-09-16T14:24:07.913759Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '<logentry'
        a << '   revision="15">'
        a << '<author>Mongo</author>'
        a << '<date>2012-09-16T14:02:05.414042Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '<logentry'
        a << '   revision="13">'
        a << '<author>Jim</author>'
        a << '<date>2012-09-16T13:51:55.741762Z</date>'
        a << '<msg></msg>'
        a << '</logentry>'
        a << '</log>'
      end      
      @entries = Svnx::Log::Entries.new lines
    end

    def create value
      ArgumentFactory.new.create value, entries: @entries
    end

    params = Array.new.tap do |a|
      a << [ IndexArgument, 22 ]
      a << [ IndexArgument, 20 ]
      a << [ [ IndexArgument, RelativeArgument ], -1 ]
      a << [ [ IndexArgument, RelativeArgument ], '-1' ]
      a << [ [ IndexArgument, RelativeArgument ], -2 ]
      %w< HEAD BASE COMMITTED PREV {2012-12-10} >.each do |word|
        # date is a StringArgument, for now
        a << [ StringArgument, word ]
      end
    end
  end
end
