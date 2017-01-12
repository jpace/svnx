#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/cat/command'

module Svnx::Cat
  class CommandTestCase < Svnx::TestCase
    EXPROOT = 'file:///Programs/Subversion/Repositories/pvntestbed.from'

    def test_cat_default
      expected = Array.new
      expected << 'line one of file two.'
      expected << 'second line'
      expected << 'third line'
      expected << 'line four'
      expected << 'line five'
      expected << 'line 6, Six, VI'
      expected << 'line 7'
      expected.collect! { |x| x + "\n" }
      
      cmd = Svnx::CatExec.new path: EXPROOT + "/SecondFile.txt"

      assert_equal expected, cmd.output
    end

    def test_cat_revision
      expected = Array.new
      expected << 'line one of file two.'
      expected << 'line four'
      expected << 'line five'
      expected << 'line 6, Six, VI'
      expected << 'line 7'
      expected.collect! { |x| x + "\n" }
      
      cmd = Svnx::CatExec.new path: EXPROOT + "/SecondFile.txt", revision: '20'

      assert_equal expected, cmd.output
    end

    def test_cat_out_of_range
      expected = Array.new
      expected << 'line one of file two.'
      expected << 'line four'
      expected << 'line five'
      expected << 'line 6, Six, VI'
      expected << 'line 7'
      expected.collect! { |x| x + "\n" }

      assert_raises(RuntimeError) do
        Svnx::CatExec.new path: EXPROOT + "/SecondFile.txt", revision: '28'
      end
    end
  end
end
