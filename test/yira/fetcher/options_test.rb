#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'yira/fetcher/options'

class Yira::Fetcher::OptionsTest < Test::Unit::TestCase
  def test_defaults
    opts = Yira::Fetcher::Options.new
    assert_equal "PIE", opts.project
    assert_equal nil, opts.name
    assert_equal "Open, Scheduled", opts.status
    assert_equal nil, opts.key
    assert_equal "Defect", opts.issuetype
    assert_equal nil, opts.version
    assert_equal "jpace", opts.assignee
  end

  def test_project
    opts = Yira::Fetcher::Options.new %w{ --project ABC }
    assert_equal "ABC", opts.project
  end  

  def test_status
    opts = Yira::Fetcher::Options.new %w{ --status New }
    assert_equal "New", opts.status
  end  

  def test_status_any
    opts = Yira::Fetcher::Options.new %w{ --any-status }
    assert_equal nil, opts.status
  end  

  def test_key
    opts = Yira::Fetcher::Options.new %w{ --key PIE-12345 }
    assert_equal "PIE-12345", opts.key
  end

  def test_assignee
    opts = Yira::Fetcher::Options.new %w{ --assignee esr }
    assert_equal "esr", opts.assignee
  end

  def test_assignee_any
    opts = Yira::Fetcher::Options.new %w{ --any-assignee }
    assert_equal nil, opts.assignee
  end

  def test_issuetype
    opts = Yira::Fetcher::Options.new %w{ --type Fix }
    assert_equal "Fix", opts.issuetype
  end  

  def test_version
    opts = Yira::Fetcher::Options.new %w{ --version 1.2.3 }
    assert_equal "1.2.3", opts.version
  end
  
end
