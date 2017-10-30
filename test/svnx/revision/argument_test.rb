#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'
require 'svnx/log/entries'
require 'svnx/revision/argument'
require 'paramesan'

module Svnx::Revision
  class ArgumentTestCase < Svnx::TestCase
    include Paramesan
    
    def setup
      xmllines = Array.new.tap do |a|
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
      @entries = Svnx::Log::Entries.new :xmllines => xmllines
    end

    def new_argument value
      Argument.new value
    end

    def create_argument value
      Argument.create value, entries: @entries
    end

    def assert_argument_value exp_value, value
      arg = create_argument value
      assert_equal exp_value, arg.value
    end

    def assert_compare op, exp, xval, yval
      x = create_argument xval
      y = create_argument yval
      assert_equal exp, x.send(op, y), "xval: #{xval}; yval: #{yval}"
    end

    def test_new_and_create_same
      x = new_argument 13
      y = create_argument 13
      assert_equal y.value, x.value
    end

    def xxxtest_range_svn_word_to_number
      # not yet handled
      assert_argument_value 'BASE:1', 'BASE:1'
    end

    def xxxtest_date
      # can't do this, because it gets converted to 1967 (as an integer)
      arg = create_argument '1967-12-10'
      assert_equal '1967-12-10', arg.to_s
    end

    param_test [
      [ '5',    '5' ], 
      [ 'HEAD', 'HEAD' ]
    ].each do |exp, value|
      arg = create_argument value
      assert_equal exp, arg.to_s, "value: #{value}"
    end

    param_test [
      [ true,  '5', '5' ], 
      [ true,  '4', '4' ], 
      [ false, '4', '5' ], 
      [ false, '5', '4' ], 
    ].each do |expeq, x, y|
      # it's the emoticon programming language
      assert_compare :==, expeq, x, y
    end

    param_test [
      [ true,  '2', '1' ], 
      [ true,  '3', '1' ], 
      [ false, '2', '2' ], 
      [ false, '2', '3' ]
    ].each do |expgt, x, y|
      assert_compare :>, expgt, x, y
    end

    def self.build_value_params
      Array.new.tap do |a|
        a << [ 19, 19   ]
        a << [ 22, 22   ]
        a << [ 13, 13   ]
        a << [ 19, '19' ]

        a.concat %w{ HEAD BASE COMMITTED PREV }.collect { |word| [ word, word ] }

        a << [ 22, -1 ]
        a << [ 20, -2 ]
        a << [ 13, -5 ]
        a << [ 22, '-1' ]
      end
    end

    param_test build_value_params.each do |exp, value|
      result = create_argument value
      assert_equal exp, result.value, "value: #{value}"
    end

    param_test [
       -6 ,
       '-6',
       '+6', 
    ].each do |value|
      assert_raises(RevisionError) do 
        create_argument value
      end
    end
  end
end
