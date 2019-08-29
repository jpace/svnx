#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'nokogiri'

module Svnx
  module Base
  end
end

# this is a parse/process on-demand list of entries, acting like an
# Enumerable.

$use_nokogiri = true

module Svnx::Base
  class Entries
    include Enumerable

    attr_reader :size

    def initialize lines
      # it's a hash, but indexed with integers, for non-sequential access:
      @entries  = Hash.new
      doc       = if $use_nokogiri
                    Nokogiri::XML lines.join('')
                  else
                    REXML::Document.new Array(lines).join
                  end
      @elements = get_elements doc
      @size     = @elements.size
    end

    def get_elements doc
      raise "get_elements must be implemented for: #{self.class}"
    end

    def create_entry xmlelement
      raise "create_entry must be implemented for: #{self.class}"
    end

    def to_index idx
      idx < 0 ? size + idx : idx
    end

    def [] idx
      if idx.kind_of? Range
        fridx = to_index idx.first
        toidx = to_index idx.last
        rg = Range.new fridx, toidx, idx.exclude_end?
        rg.collect { |x| self[x] }
      else
        if idx >= size
          raise "error: index #{idx} is not in range(0 .. #{size})"
        else
          idx = to_index idx
        end
        if entry = @entries[idx]
          return entry
        end
        @entries[idx] = create_entry @elements[idx]
      end
    end
      
    def each(&blk)
      (0 ... size).collect do |idx|
        @entries[idx] ||= create_entry @elements[idx]
      end.each(&blk)
    end
  end
end
