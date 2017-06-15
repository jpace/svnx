#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class File
    attr_reader :filename
    attr_reader :revision

    def initialize args
      @filename = args[:filename]
      @revision = args[:revision]
    end
  end

  class Header
    attr_reader :filename
    attr_reader :from
    attr_reader :to
    
    def initialize args
      @filename = args[:filename]
      @from = args[:from]
      @to = args[:to]
    end
  end

  class HunkRange
    attr_reader :line
    attr_reader :length

    def initialize line, length
      @line = line
      @length = length
    end
  end

  class HunkRanges
    attr_reader :from
    attr_reader :to

    def initialize from, to
      @from = from
      @to = to
    end
  end

  # unused; I prefer a two-element array: [ :added, "sometext" ]

  class Line
    attr_reader :type
    attr_reader :text

    def initialize type, text
      @type = type
      @text = text
    end
  end

  class Hunk
    attr_reader :ranges
    attr_reader :lines

    def initialize ranges, lines
      @ranges = ranges
      @lines = lines
    end
  end

  # all diffs for one file
  class SvnFileDiff
    attr_reader :header
    attr_reader :hunks
    
    def initialize header, hunks = Array.new
      @header = header
      @hunks = hunks
    end
  end
end
