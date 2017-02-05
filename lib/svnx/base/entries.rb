#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'logue/loggable'

module Svnx
  module Base
  end
end

# this is a parse/process on-demand list of entries, acting like an
# Enumerable.

class Svnx::Base::Entries
  include Logue::Loggable, Enumerable

  attr_reader :size

  def initialize args = Hash.new
    # it's a hash, but indexed with integers, for non-sequential access:
    @entries = Hash.new

    lines = args[:xmllines] || args[:lines]

    if lines.kind_of? Array
      lines = lines.join ''
    end

    doc = REXML::Document.new lines
    
    @elements = get_elements doc
    @size = @elements.size
  end

  def get_elements doc
    raise "get_elements must be implemented for: #{self.class}"
  end

  def create_entry xmlelement
    raise "create_entry must be implemented for: #{self.class}"
  end

  # this doesn't handle negative indices
  def [] idx
    if entry = @entries[idx]
      return entry
    end
    if idx < 0 && idx >= size
      raise "error: index #{idx} is not in range(0 .. #{size})"
    end
    @entries[idx] = create_entry @elements[idx + 1]
  end

  def each(&blk)
    # all elements must be processed before each can run:
    if @elements
      # a little confusing here: REXML does each_with_index with idx
      # zero-based, but elements[0] is invalid.
      @elements.each_with_index do |element, idx|
        @entries[idx] ||= create_entry(element)
      end

      @elements = nil
    end

    @entries.keys.sort.collect { |idx| @entries[idx] }.each(&blk)
  end
end
