#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/project'
require 'svnx/propget/entries'
require 'svnx/tc'

module Svnx
  class ProjectTest < Svnx::TestCase
    class MockCommandLine < Svnx::Base::MockCommandLine
      ELEMENTS = Array.new
      
      def execute
        ELEMENTS << self
        super
      end
    end

    def self.to_args args = Hash.new
      args.merge({ cmdlinecls: MockCommandLine })
    end

    def self.dir_args dirname = "/tmp/svnx-test"
      Hash[dir: dirname, cmdlinecls: MockCommandLine]
    end

    def self.url_args urlname = "p://svnx/abc"
      Hash[url: urlname, cmdlinecls: MockCommandLine]
    end

    def self.dir_url_args dirname = "/tmp/svnx-test", urlname = "p://svnx/abc"
      Hash[dir: dirname, url: urlname, cmdlinecls: MockCommandLine]
    end

    # dir and url
    
    param_test [
      { expdir: "/tmp/svnx-test", args: dir_args },
      { expurl: "p://svnx/abc",   args: url_args },  
      { expdir: "/tmp/svnx-test", expurl: "p://svnx/abc", args: dir_url_args }
    ] do |args|
      expdir = args[:expdir]
      expurl = args[:expurl]
      proj   = Svnx::Project.new args[:args]
      
      assert_equal expdir, proj.dir, "args: #{args}"
      assert_equal expurl, proj.url, "args: #{args}"
    end
    
    def mock_cmdline
      Svnx::Base::MockCommandLine.new
    end
    
    # where

    param_test [
      { exp: "/tmp/svnx-test", args: dir_args }, 
      { exp: "p://svnx/abc",   args: url_args }, 
      # url takes priority when both are specified:
      { exp: "p://svnx/abc",   args: dir_url_args }
    ] do |args|
      exp  = args[:exp]
      proj = Svnx::Project.new args[:args]
      
      assert_equal exp, proj.where, "args: #{args}"
    end

    # not merge, because it takes more than one dir/url, so it's not on a project now
    # and not commit because taht validates options, and cmdlinecls and url are not valid for it

    param_test [
      :info,
      :update,
      :log,
      :diff,
      :propset,
      :propget,
    ] do |meth|
      MockCommandLine::ELEMENTS.clear
      proj = Svnx::Project.new self.class.dir_args
      proj.send meth, cmdlinecls: MockCommandLine
      el = MockCommandLine::ELEMENTS.last
      assert_true el.executed
      assert_equal el.subcommand, meth.to_s
    end

    param_test [
      { revision: 123   },
      { limit:    123   },
      { verbose:  true  },
      { url:      "abc" },
      { path:     "def" },
    ] do |args|
      proj = Svnx::Project.new self.class.dir_args
      args = args.merge({ cmdlinecls: MockCommandLine })
      proj.log args
    end
  end
end
