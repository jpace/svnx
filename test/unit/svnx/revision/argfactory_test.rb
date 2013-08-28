#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/log/entries'
require 'svnx/revision/argument'
require 'resources'

module SVNx::Revision
  class ArgumentFactoryTestCase < SVNx::TestCase
    def setup
      xmllines = Resources::PT_LOG_R22_13_SECONDFILE_TXT.readlines
      @entries = SVNx::Log::Entries.new :xmllines => xmllines
    end

    def test_create
      arg = ArgumentFactory.new.create 14, entries: @entries
      assert_not_nil arg
    end

    def test_index_argument
      arg = ArgumentFactory.new.create 14, entries: @entries
      assert_kind_of IndexArgument, arg
    end

    def test_string_svn_words
      %w{ HEAD BASE COMMITTED PREV }.each do |word|
        arg = ArgumentFactory.new.create word, entries: @entries
        assert_kind_of StringArgument, arg
      end
    end
  end
end
