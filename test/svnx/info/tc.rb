#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx
  module Info
  end
end

class Svnx::Info::TestCase < Svnx::TestCase
  EXPROOT = 'file:///Programs/Subversion/Repositories/pvntestbed.from'

  def assert_entry_equals entry, expdata
    [ :url, :path, :root, :kind, :revision ].each do |field|
      assert_equal expdata[field], entry.send(field), "field: #{field}"
    end
  end
end
