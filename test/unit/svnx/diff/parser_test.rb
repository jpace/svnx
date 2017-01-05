#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'logue/loggable'
require 'svnx/diff/parser'

Logue::Log.level = Logue::Log::INFO

class DiffParserTest < Test::Unit::TestCase
  include Logue::Loggable

  # header file

  def assert_parse_header_file exp_filename, exp_revision, lines
    p = SvnDiffParser.new
    f = p.parse_header_file lines
    assert_equal exp_filename, f.filename
    assert_equal exp_revision, f.revision
  end
  
  def test_parse_header_file_from_with_revision
    lines = Array.new
    lines << "--- x/y/Z.t\t(revision 11)"
    filename = "x/y/Z.t"
    revision = 11
    assert_parse_header_file filename, revision, lines
    assert_empty lines
  end
  
  def test_parse_header_file_to_with_revision
    lines = Array.new
    lines << "+++ x/y/Z.t\t(revision 12)"
    filename = "x/y/Z.t"
    revision = 12
    assert_parse_header_file filename, revision, lines
    assert_empty lines
  end
  
  def test_parse_header_file_to_without_revision
    lines = Array.new
    lines << "+++ x/y/Z.t\t(nonexistent)"
    filename = "x/y/Z.t"
    revision = nil
    assert_parse_header_file filename, revision, lines
    assert_empty lines
  end

  # header section

  def assert_parse_header_section exp_filename, lines
    p = SvnDiffParser.new
    s = p.parse_header_section lines
    assert_equal exp_filename, s.filename
    assert_not_nil s.from
    assert_not_nil s.to
  end

  def test_parse_header_section 
    lines = Array.new
    lines << "Index: x/y/Z.t"
    lines << "==================================================================="
    lines << "--- x/y/Z.t\t(revision 11)"
    lines << "+++ x/y/Z.t\t(revision 12)"
    assert_parse_header_section "x/y/Z.t", lines
    assert_empty lines
  end

  # ranges

  def assert_parse_ranges exp_from_line, exp_from_length, exp_to_line, exp_to_length, line
    p = SvnDiffParser.new
    ranges = p.parse_ranges line
    
    assert_equal exp_from_line, ranges.from.line
    assert_equal exp_from_length, ranges.from.length
    assert_equal exp_to_line, ranges.to.line
    assert_equal exp_to_length, ranges.to.length
  end
  
  def test_parse_ranges_deladd_deladd
    lines = Array.new
    lines << "@@ -28,7 +28,10 @@"

    assert_parse_ranges 28, 7, 28, 10, lines
    assert_empty lines
  end

  def test_parse_ranges_one_line
    # apparently (I haven't seen it) this is valid output (for one line of length):
    
    lines = Array.new
    lines << "@@ -28 +28 @@"

    assert_parse_ranges 28, 1, 28, 1, lines
    assert_empty lines
  end

  # hunks

  def assert_parse_hunk explines, lines
    p = SvnDiffParser.new
    hunk = p.parse_hunk lines
    assert_equal explines, hunk.lines
  end
  
  def test_parse_hunk_deladd_add
    lines = Array.new
    lines << "@@ -28,7 +28,10 @@"
    lines << "     public static List<Branch> getAll() {"
    lines << "         return branches;"
    lines << "     }"
    lines << "-    "
    lines << "+"
    lines << "+    /**"
    lines << "+     * Returns the version based on the Subversion URL."
    lines << "+     */"
    lines << "     public static String getVersion(String url) {"
    lines << "         tr.Ace.onGreen(\"url\", url);"
    lines << "         if (url == null) {"
    lines << "@@ -43,6 +46,9 @@"

    explines = Array.new
    explines << [ :context, "    public static List<Branch> getAll() {" ]
    explines << [ :context, "        return branches;" ]
    explines << [ :context, "    }" ]
    explines << [ :deleted, "    " ]
    explines << [ :added,   "" ]
    explines << [ :added,   "    /**" ]
    explines << [ :added,   "     * Returns the version based on the Subversion URL." ]
    explines << [ :added,   "     */" ]
    explines << [ :context, "    public static String getVersion(String url) {" ]
    explines << [ :context, "        tr.Ace.onGreen(\"url\", url);" ]
    explines << [ :context, "        if (url == null) {" ]

    assert_parse_hunk explines, lines
    assert_equal [ "@@ -43,6 +46,9 @@" ], lines
  end

  def test_parse_hunk_no_newline_at_end_of_file
    lines = Array.new
    lines << "@@ -28,7 +28,10 @@"
    lines << "     public static List<Branch> getAll() {"
    lines << "         return branches;"
    lines << "     }"
    lines << "-    "
    lines << "+"
    lines << "+    /**"
    lines << "+     * Returns the version based on the Subversion URL."
    lines << "+     */"
    lines << "     public static String getVersion(String url) {"
    lines << "         tr.Ace.onGreen(\"url\", url);"
    lines << "         if (url == null) {"
    lines << "\\ No newline at end of file"
    lines << "@@ -43,6 +46,9 @@"
    
    explines = Array.new
    explines << [ :context, "    public static List<Branch> getAll() {" ]
    explines << [ :context, "        return branches;" ]
    explines << [ :context, "    }" ]
    explines << [ :deleted, "    " ]
    explines << [ :added,   "" ]
    explines << [ :added,   "    /**" ]
    explines << [ :added,   "     * Returns the version based on the Subversion URL." ]
    explines << [ :added,   "     */" ]
    explines << [ :context, "    public static String getVersion(String url) {" ]
    explines << [ :context, "        tr.Ace.onGreen(\"url\", url);" ]
    explines << [ :context, "        if (url == null) {" ]
    explines << [ :context, :no_newline ]

    assert_parse_hunk explines, lines
    assert_equal [ "@@ -43,6 +46,9 @@" ], lines
  end
  
  def assert_parse_hunks exp_num_hunks, lines
    p = SvnDiffParser.new
    hunks = p.parse_hunks lines
    assert_equal exp_num_hunks, hunks.size
  end
  
  def test_parse_hunks_deladd_add
    lines = Array.new
    lines << "@@ -28,7 +28,10 @@"
    lines << "     public static List<Branch> getAll() {"
    lines << "         return branches;"
    lines << "     }"
    lines << "-    "
    lines << "+"
    lines << "+    /**"
    lines << "+     * Returns the version based on the Subversion URL."
    lines << "+     */"
    lines << "     public static String getVersion(String url) {"
    lines << "         tr.Ace.onGreen(\"url\", url);"
    lines << "         if (url == null) {"
    lines << "@@ -43,6 +46,9 @@"
    lines << "         return null;"
    lines << "     }"
    lines << " "
    lines << "+    /**"
    lines << "+     * Returns the branch for the given version."
    lines << "+     */"
    lines << "     public static Branch findBranch(String version) {"
    lines << "         if (version == null) {"
    lines << "             return null;"

    expected = 2

    assert_parse_hunks expected, lines
    assert_empty lines
  end

  def assert_parse_file_diff exp_num_hunks, lines
    p = SvnDiffParser.new
    diffs = p.parse_file_diff lines
    assert_equal exp_num_hunks, diffs.hunks.size
  end

  def test_parse_file_diff
    lines = Array.new
    lines << "Index: path/to/dir/TestBranches.java"
    lines << "==================================================================="
    lines << "--- path/to/dir/TestBranches.java\t(nonexistent)"
    lines << "+++ path/to/dir/TestBranches.java\t(revision 1501158)"
    lines << "@@ -0,0 +1,38 @@"
    lines << "+package com.example.ex;"
    lines << "+"
    lines << "+import java.util.List;"
    lines << "+import junit.framework.TestCase;"
    lines << "+"
    lines << "+public class TestBranches extends TestCase {"
    lines << "+    public TestBranches(String name) {"
    lines << "+        super(name);"
    lines << "+        tr.Ace.setVerbose(true);"
    lines << "+    }"
    lines << "+"
    lines << "+    private Branch assertBranch(String expVersion, String expJavaVersion, String expBuilder, String expUrl) {"
    lines << "+        return null;"
    lines << "+    }"
    lines << "+"
    lines << "+    public void testGetAll() {"
    lines << "+        List<Branch> branches = Branches.getAll();"
    lines << "+        assertEquals(12, branches.size());"
    lines << "+    }"
    lines << "+"
    lines << "+    private Branch assertFindBranch(boolean expectedFound, String version) {"
    lines << "+        Branch branch = Branches.findBranch(version);"
    lines << "+        assertEquals(\"version: \" + version + \"; branch: \" + branch, expectedFound, branch != null);"
    lines << "+        return branch;"
    lines << "+    }"
    lines << "+"
    lines << "+    public void testFindBranchTrue() {"
    lines << "+        assertFindBranch(true, \"8.2.1\");"
    lines << "+        assertFindBranch(true, \"821\");"
    lines << "+        assertFindBranch(true, \"8.2\");"
    lines << "+        assertFindBranch(true, \"82\");"
    lines << "+    }"
    lines << "+"
    lines << "+    public void testFindBranchFalse() {"
    lines << "+        assertFindBranch(false, \"8.2.3\");"
    lines << "+        assertFindBranch(false, \"83\");"
    lines << "+    }"
    lines << "+}"
    lines << "Index: path/to/dir/Branches.java"
    
    assert_parse_file_diff 1, lines
    assert_equal [ "Index: path/to/dir/Branches.java" ], lines
  end

  def test_parse_file_diff_no_content
    lines = Array.new
    lines << "Index: path/to/empty/File.txt"
    lines << "==================================================================="
    lines << "Index: path/to/next/File.txt"
    
    assert_parse_file_diff 0, lines
    assert_equal [ "Index: path/to/next/File.txt" ], lines
  end
end
