#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entries'
require 'svnx/log/xml'
require 'svnx/tc'

module Svnx::Log
  class EntriesPerformanceTest < Svnx::TestCase
    def x_test_one
      lines = Pathname.new('/tmp/svnlogs/1558452430/log-develop.xml').readlines
      $stderr.puts
      $stderr.puts "reading log entries ..."
      entries = Entries.new lines
      
      $stderr.puts "getting entries size ..."
      size = entries.size
      $stderr.puts "# entries: #{size}"
      $stderr.puts "done getting entries size."

      $stderr.puts "reading each entry ..."

      entry = nil
      
      idx = 0
      while idx < size
        $stderr.print "\r#{idx} ..."
        entry = entries[idx]
        idx += 1
      end
      puts
      $stderr.puts "done reading each entry."
      $stderr.puts
    end
  end
end
