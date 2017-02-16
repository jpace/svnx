#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/project'
require 'svnx/tc'

class Svnx::ProjectTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  # init
  
  def assert_init expdir, expurl, args
    proj = Svnx::Project.new args
    assert_equal expdir, proj.dir, "args: #{args}"
    assert_equal expurl, proj.url, "args: #{args}"
  end
  
  def test_init_dir
    assert_init "/tmp/svnx-test", nil, dir: "/tmp/svnx-test"
  end

  def test_init_url
    assert_init nil, "p://svnx/abc", url: "p://svnx/abc"
  end
  
  def test_init_url_and_dir
    assert_init "/tmp/svnx-test", "p://svnx/abc", dir: "/tmp/svnx-test", url: "p://svnx/abc"
  end

  # where
  
  def assert_where exp, args
    proj = Svnx::Project.new args
    assert_equal exp, proj.where, "args: #{args}"
  end  
  
  def test_where_dir
    assert_where "/tmp/svnx-test", dir: "/tmp/svnx-test"
  end

  def test_where_url
    assert_where "p://svnx/abc", url: "p://svnx/abc"
  end
  
  def test_where_url_and_dir
    # url takes priority
    assert_where "p://svnx/abc", dir: "/tmp/svnx-test", url: "p://svnx/abc"
  end

  # command delegation

  def assert_execute_command cmdlinecls, projmeth, initargs, cmdargs
    cmdlinecls.executed = false
    msg = "initargs: #{initargs}; cmdargs: #{cmdargs}"
    proj = Svnx::Project.new initargs
    assert_false cmdlinecls.executed, msg
    proj.send projmeth, cmdargs
    assert_true cmdlinecls.executed, msg
  end

  # info
  
  def assert_info initargs, infoargs
    assert_execute_command Svnx::Base::CommandLine, :info, initargs, infoargs
  end  
  
  def test_info_dir
    assert_info({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_info_url
    assert_info({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_info_url_and_dir
    assert_info({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end

  # update
  
  def assert_update initargs, updateargs
    assert_execute_command Svnx::Base::CommandLine, :update, initargs, updateargs
  end  
  
  def test_update_dir
    assert_update({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_update_url
    assert_update({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_update_url_and_dir
    assert_update({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end  

  # merge
  
  def assert_merge initargs, mergeargs
    assert_execute_command Svnx::Base::CommandLine, :merge, initargs, mergeargs
  end  
  
  def test_merge_dir
    assert_merge({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_merge_url
    assert_merge({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_merge_url_and_dir
    assert_merge({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end  

  # commit
  
  def assert_commit initargs, commitargs
    assert_execute_command Svnx::Base::CommandLine, :commit, initargs, commitargs
  end  
  
  def test_commit_dir
    assert_commit({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_commit_url
    assert_commit({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_commit_url_and_dir
    assert_commit({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end  

  # log
  
  def assert_log initargs, logargs
    assert_execute_command Svnx::Base::CommandLine, :log, initargs, logargs
  end  
  
  def test_log_dir
    assert_log({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_log_url
    assert_log({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_log_url_and_dir
    assert_log({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end

  # diff
  
  def assert_diff initargs, diffargs
    assert_execute_command Svnx::Base::CommandLine, :diff, initargs, diffargs
  end  
  
  def test_diff_dir
    assert_diff({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_diff_url
    assert_diff({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_diff_url_and_dir
    assert_diff({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end  
  
  # propset
  
  def assert_propset initargs, propsetargs
    assert_execute_command Svnx::Base::CommandLine, :propset, initargs, propsetargs
  end  
  
  def test_propset_dir
    assert_propset({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_propset_url
    assert_propset({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_propset_url_and_dir
    assert_propset({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end  
  
  # propget
  
  def assert_propget initargs, propgetargs
    assert_execute_command Svnx::Base::CommandLine, :propget, initargs, propgetargs
  end  
  
  def test_propget_dir
    assert_propget({ dir: "/tmp/svnx-test" }, Hash.new)
  end

  def test_propget_url
    assert_propget({url: "p://svnx/abc" }, Hash.new)
  end
  
  def test_propget_url_and_dir
    assert_propget({dir: "/tmp/svnx-test", url: "p://svnx/abc" }, Hash.new)
  end    
end