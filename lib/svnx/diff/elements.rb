#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

class SvnDiffFile
  attr_reader :filename
  attr_reader :revision

  def initialize args
    @filename = args[:filename]
    @revision = args[:revision]
  end
end

class SvnDiffHeader
  attr_reader :filename
  attr_reader :from
  attr_reader :to
  
  def initialize args
    @filename = args[:filename]
    @from = args[:from]
    @to = args[:to]
  end
end

class SvnDiffHunkRange
  attr_reader :line
  attr_reader :length

  def initialize line, length
    @line = line
    @length = length
  end
end

class SvnDiffHunkRanges
  attr_reader :from
  attr_reader :to

  def initialize from, to
    @from = from
    @to = to
  end
end

class SvnDiffHunkLine
  attr_reader :type
  attr_reader :text

  def initialize type, text
    @type = type
    @text = text
  end
end

class SvnDiffHunk
  attr_reader :ranges
  attr_reader :lines

  def initialize ranges, lines
    @ranges = ranges
    @lines = lines
  end
end

class SvnFileDiff
  attr_reader :header
  attr_reader :hunks
  
  def initialize header
    @header = header
    @hunks = Array.new
  end
end
