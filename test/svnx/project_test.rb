#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/project'
require 'svnx/tc'
require 'paramesan'

class Svnx::ProjectTest < Svnx::Common::TestCase
  include Paramesan

  # dir and url
  
  param_test [
    { expdir: "/tmp/svnx-test", args: { dir: "/tmp/svnx-test", cls: Svnx::Base::MokkCommandLine } },
    { expurl: "p://svnx/abc", args: { url: "p://svnx/abc", cls: Svnx::Base::MokkCommandLine} },
    { expdir: "/tmp/svnx-test", expurl: "p://svnx/abc", args: { dir: "/tmp/svnx-test", url: "p://svnx/abc", cls: Svnx::Base::MokkCommandLine } }
  ].each do |args|
    expdir = args[:expdir]
    expurl = args[:expurl]
    proj = Svnx::Project.new args[:args]
    assert_equal expdir, proj.dir, "args: #{args}"
    assert_equal expurl, proj.url, "args: #{args}"
  end
  
  def mock_cmdline
    Svnx::Base::MockCommandLine.new
  end
  
  # where

  param_test [
    { exp: "/tmp/svnx-test", args: { dir: "/tmp/svnx-test", cls: Svnx::Base::MokkCommandLine } },
    { exp: "p://svnx/abc",   args: { url: "p://svnx/abc" } },
    # url takes priority when both are specified:
    { exp: "p://svnx/abc",   args: { dir: "/tmp/svnx-test", url: "p://svnx/abc" } }
  ].each do |args|
    exp = args[:exp]
    proj = Svnx::Project.new args[:args]
    assert_equal exp, proj.where, "args: #{args}"
  end  

  # command delegation

  def assert_execute_command projmeth, initargs = Hash.new
    proj = Svnx::Project.new dir: "/tmp/svnx-test", cls: Svnx::Base::MokkCommandLine
    proj.send projmeth, cls: Svnx::Base::MokkCommandLine
    assert_true Svnx::Base::COMMAND_LINE_HISTORY[-1].executed, projmeth.to_s
  end

  # info
  
  def test_info_exec
    assert_execute_command :info
  end

  # update
  
  def test_update_exec
    assert_execute_command :update
  end

  # merge
  
  def test_merge_exec
    assert_execute_command :merge
  end

  # commit
  
  def test_commit_exec
    # assert_execute_command :commit
  end

  # log
  
  def test_log_exec
    assert_execute_command :log
  end

  # diff
  
  def test_diff_exec
    assert_execute_command :diff
  end
  
  # propset
  
  def test_propset_exec
    assert_execute_command :propset
  end
  
  # propget
  
  def test_propget_exec
    assert_execute_command :propget
  end
end
