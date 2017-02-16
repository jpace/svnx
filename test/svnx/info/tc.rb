#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'resources'

module Svnx
  module Info
  end
end

module Svnx::Info
  class TestCase < Svnx::TestCase
    EXPROOT = 'file:///Programs/Subversion/Repositories/pvntestbed.from'

    def assert_entry_equals entry, expdata
      [ :url, :path, :root, :kind, :revision ].each do |field|
        assert_equal expdata[field], entry.send(field), "field: #{field}"
      end
    end
  end
end
