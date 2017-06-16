#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/project'
require 'svnx/tc'

class Svnx::ProjectTest < Svnx::Common::TestCase
  def mock_cmdline
    Svnx::Base::MockCommandLine.new
  end
  
  # init
  
  def assert_init expdir: nil, expurl: nil, **args
    proj = Svnx::Project.new args
    assert_equal expdir, proj.dir, "args: #{args}"
    assert_equal expurl, proj.url, "args: #{args}"
  end
  
  def test_init_dir
    assert_init expdir: "/tmp/svnx-test", dir: "/tmp/svnx-test", cls: Svnx::Base::MokkCommandLine
  end

  def test_init_url
    assert_init expurl: "p://svnx/abc", url: "p://svnx/abc", cls: Svnx::Base::MokkCommandLine
  end
  
  def test_init_url_and_dir
    assert_init expdir: "/tmp/svnx-test", expurl: "p://svnx/abc", dir: "/tmp/svnx-test", url: "p://svnx/abc", cls: Svnx::Base::MokkCommandLine
  end
  
  # where
 
  def assert_where exp, **args
    proj = Svnx::Project.new args
    assert_equal exp, proj.where, "args: #{args}"
  end  
  
  def test_where_dir
    assert_where "/tmp/svnx-test", dir: "/tmp/svnx-test", cls: Svnx::Base::MokkCommandLine
  end

  def test_where_url
    assert_where "p://svnx/abc", url: "p://svnx/abc"
  end
  
  def test_where_url_and_dir
    # url takes priority
    assert_where "p://svnx/abc", dir: "/tmp/svnx-test", url: "p://svnx/abc"
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
