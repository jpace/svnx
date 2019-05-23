#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'nokogiri'
require 'logue/loggable'

module Svnx
  module Base
  end
end

# this is a parse/process on-demand list of entries, acting like an
# Enumerable.

$use_nokogiri = true

module Svnx::Base
  class Entries
    include Logue::Loggable, Enumerable

    attr_reader :size

    def initialize lines
      # it's a hash, but indexed with integers, for non-sequential access:
      @entries  = Hash.new
      doc       = if $use_nokogiri
                    Nokogiri::XML Array(lines).join
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

    def [] idx
      if entry = @entries[idx]
        return entry
      end
      if idx >= size
        raise "error: index #{idx} is not in range(0 .. #{size})"
      elsif idx < 0
        idx = size + idx
      end
      @entries[idx] = create_entry @elements[idx]
    end

    def each(&blk)
      # all elements must be processed before each can run:
      if @elements
        @elements.each_with_index do |element, idx|
          @entries[idx] ||= create_entry element
        end

        @elements = nil
      end

      @entries.keys.sort.collect { |idx| @entries[idx] }.each(&blk)
    end
  end
end
