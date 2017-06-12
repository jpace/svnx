#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'pathname'
require 'logue/loggable'

class DiffTest # < Test::Unit::TestCase
  include Logue::Loggable
  
  def assert_diff_record exp_filename, exp_fromfile, exp_tofile, drec
    info "exp_filename: #{exp_filename}"
    info "drec: #{drec}"
    assert_equal exp_filename, drec.header.filename
    # assert_equal exp_fromfile, drec.header.fromfile
    # assert_equal exp_tofile, drec.header.tofile
  end
  
  def test_something
    lines = DATA.readlines

    result = SvnDiffResult.new lines
    puts "result: #{result}"

    puts "result.diffs.keys: #{result.diffs.keys}"

    result.diffs.sort.each do |filename, diff|
      puts "filename: #{filename}"
      puts "diff: #{diff}"
      puts "diff.header.filename: #{diff.header.filename}"
      puts "diff.header.fromfile: #{diff.header.fromfile}"
      puts "diff.header.tofile: #{diff.header.tofile}"
      diff.sections.each do |section|
        puts "section: #{section.inspect}"
      end
      puts
    end

    brfn = "src/main/java/org/incava/grace/is/Branches.java"
    tbfn = "src/test/java/org/incava/grace/is/TestBranches.java"

    assert_equal [ brfn, tbfn ], result.diffs.keys.sort

    assert_diff_record(brfn,
                       "--- src/main/java/org/incava/grace/is/Branches.java\t(revision 1501157)",
                       "+++ src/main/java/org/incava/grace/is/Branches.java\t(revision 1501158)",
                       result.diffs[brfn])
    
    assert_diff_record(tbfn,
                       "--- src/test/java/org/incava/grace/is/TestBranches.java\t(nonexistent)",
                       "+++ src/test/java/org/incava/grace/is/TestBranches.java\t(revision 1501158)",
                       result.diffs[tbfn])
  end
end


__END__
Index: src/test/java/org/incava/grace/is/TestBranches.java
===================================================================
--- src/test/java/org/incava/grace/is/TestBranches.java	(nonexistent)
+++ src/test/java/org/incava/grace/is/TestBranches.java	(revision 1501158)
@@ -0,0 +1,38 @@
+package org.incava.grace.is;
+
+import java.util.List;
+import junit.framework.TestCase;
+
+public class TestBranches extends TestCase {
+    public TestBranches(String name) {
+        super(name);
+        tr.Ace.setVerbose(true);
+    }
+
+    private Branch assertBranch(String expVersion, String expJavaVersion, String expBuilder, String expUrl) {
+        return null;
+    }
+
+    public void testGetAll() {
+        List<Branch> branches = Branches.getAll();
+        assertEquals(12, branches.size());
+    }
+
+    private Branch assertFindBranch(boolean expectedFound, String version) {
+        Branch branch = Branches.findBranch(version);
+        assertEquals(\"version: \" + version + \"; branch: \" + branch, expectedFound, branch != null);
+        return branch;
+    }
+
+    public void testFindBranchTrue() {
+        assertFindBranch(true, \"8.2.1\");
+        assertFindBranch(true, \"821\");
+        assertFindBranch(true, \"8.2\");
+        assertFindBranch(true, \"82\");
+    }
+
+    public void testFindBranchFalse() {
+        assertFindBranch(false, \"8.2.3\");
+        assertFindBranch(false, \"83\");
+    }
+}
Index: src/main/java/org/incava/grace/is/Branches.java
===================================================================
--- src/main/java/org/incava/grace/is/Branches.java	(revision 1501157)
+++ src/main/java/org/incava/grace/is/Branches.java	(revision 1501158)
@@ -28,7 +28,10 @@
     public static List<Branch> getAll() {
         return branches;
     }
-    
+
+    /**
+     * Returns the version based on the Subversion URL.
+     */
     public static String getVersion(String url) {
         tr.Ace.onGreen(\"url\", url);
         if (url == null) {
@@ -43,6 +46,9 @@
         return null;
     }
 
+    /**
+     * Returns the branch for the given version.
+     */
     public static Branch findBranch(String version) {
         if (version == null) {
             return null;
    
