#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/entries'
require 'svnx/tc'
require 'svnx/info/xml'

module Svnx::Info
  class EntriesTestCase < Svnx::TestCase
    EXPROOT = 'file:///Programs/Subversion/Repositories/pvntestbed.from'

    param_test [
      [ 'dirzero/SixthFile.txt', 'file', '22', 0 ],
      [ 'src/ruby/dog.rb',       'file', '0',  1 ],
      [ 'FirstFile.txt',         'file', '22', 2 ],
    ] do |exppath, expkind, exprevision, idx|
      entries    = Svnx::Info::Entries.new XML::LINES
      entry      = entries[idx]
      exp        = { path: exppath, kind: expkind, revision: exprevision }
      exp[:root] = EXPROOT
      exp[:url]  = EXPROOT + '/' + exppath
      
      [ :url, :path, :root, :kind, :revision ].each do |field|
        assert_equal exp[field], entry.send(field), "field: #{field}"
      end
    end
  end
end
