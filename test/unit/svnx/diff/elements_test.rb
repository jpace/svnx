#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'pathname'
require 'svnx/diff/elements'

class Svnx::Diff::ElementTest < Test::Unit::TestCase
  def create_diff_file fname, rev
    Svnx::Diff::File.new filename: fname, revision: rev
  end
    
  def test_diff_file
    f = create_diff_file "abc.t", 1234
    assert_equal "abc.t", f.filename
    assert_equal 1234, f.revision
  end

  def create_header fname, from, to
    Svnx::Diff::Header.new filename: fname, from: from, to: to    
  end

  def test_diff_header
    # these filenames are usually the same:
    from   = create_diff_file "abc-from.t", 12
    to     = create_diff_file "abc-to.t",   34
    header = create_header "abc.t", from, to
    
    assert_equal "abc.t", header.filename
    assert_equal from, header.from
    assert_equal to, header.to
  end

  def create_range line, length
    Svnx::Diff::HunkRange.new line, length
  end

  def test_diff_hunk_range
    range = create_range 1, 3
    
    assert_equal 1, range.line
    assert_equal 3, range.length
  end

  def create_ranges from, to
    Svnx::Diff::HunkRanges.new from, to
  end

  def test_diff_hunk_ranges
    from   = create_range 1, 3
    to     = create_range 4, 6
    ranges = create_ranges from, to
    
    assert_equal from, ranges.from
    assert_equal to, ranges.to
  end

  def create_hunk ranges, lines
    Svnx::Diff::Hunk.new ranges, lines
  end

  def test_diff_hunk
    from   = create_range 1, 3
    to     = create_range 4, 6
    ranges = create_ranges from, to

    lines = [ [ :deleted, "l1" ], [ :added, "l2" ] ]
    hunk = create_hunk ranges, lines

    assert_equal ranges, hunk.ranges
    assert_equal lines, hunk.lines
  end

  def test_file_diff
    from   = create_diff_file "abc-from.t", 12
    to     = create_diff_file "abc-to.t",   34
    header = create_header "abc.t", from, to
    
    hunks = 3.times.collect do |n|
      from   = create_range n + 1, n + 3
      to     = create_range n * 2, n * 2 + 3
      ranges = create_ranges from, to

      lines = [ [ :deleted, "l1" ], [ :added, "l2" ] ]
      create_hunk ranges, lines
    end

    fdiff = SvnFileDiff.new header, hunks
    
    assert_equal header, fdiff.header
    assert_equal hunks, fdiff.hunks
  end
end
