#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/diff/elements'

class SvnDiffParser
  include Logue::Loggable

  def parse_header_file line
    re = Regexp.new '^[\-\+]{3} (.*)\t\((?:nonexistent|revision (\d+))\)'
    if md = re.match(line)
      SvnDiffFile.new filename: md[1], revision: md[2] && md[2].to_i
    end
  end
  
  def parse_header_section lines
    re = Regexp.new '^Index: (.*)'
    if md = re.match(lines[0])
      filename = md[1]      
      lines.shift
      
      # discard the ==== line:
      lines.shift
      
      SvnDiffHeader.new filename: filename, from: parse_header_file(lines.shift), to: parse_header_file(lines.shift)
    end
  end

  def parse_ranges lines
    range_re = Regexp.new '@@ \-(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@'
    if md = range_re.match(lines[0])
      lines.shift
      
      from, to = [ 1, 3 ].collect do |idx|
        SvnDiffHunkRange.new md[idx].to_i, (md[idx + 1] || 1).to_i
      end
      
      SvnDiffHunkRanges.new from, to
    end
  end

  def parse_hunk lines
    if ranges = parse_ranges(lines)
      SvnDiffHunk.new(ranges, Array.new).tap do |hunk|
        char_to_type = { ' ' => :context, '+' => :added,  '-' => :deleted }
        
        while !lines.empty?
          if lines[0] == "\\ No newline at end of file"
            hunk.lines << [ :context, :no_newline ]
            lines.shift
          elsif type = char_to_type[lines[0][0]]
            hunk.lines << [ type, lines.shift[1 .. -1] ]
          else
            break
          end
        end
      end
    end
  end

  def parse_hunks lines
    hunks = Array.new
    while !lines.empty?
      if hunk = parse_hunk(lines)
        hunks << hunk
      else
        break
      end
    end
    hunks
  end

  def parse_file_diff lines
    if header = parse_header_section(lines)
      SvnFileDiff.new(header).tap do |diff|
        while !lines.empty?
          if hunk = parse_hunk(lines)
            diff.hunks << hunk
          else
            break
          end
        end
      end
    end
  end
end
