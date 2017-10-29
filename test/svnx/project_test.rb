#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/project'
require 'svnx/propget/entries'
require 'svnx/tc'
require 'svnx/mock'
require 'paramesan'

module Svnx
  class ProjectTest < Svnx::TestCase
    include Paramesan

    class MockCommandLine < Svnx::Base::MockCommandLine
      ELEMENTS = Array.new
      
      def execute
        ELEMENTS << self
        super
      end
    end

    # dir and url
    
    param_test [
      { expdir: "/tmp/svnx-test", args: { dir: "/tmp/svnx-test", cls: MockCommandLine } }, 
      { expurl: "p://svnx/abc",   args: { url: "p://svnx/abc",   cls: MockCommandLine } },  
      { expdir: "/tmp/svnx-test", expurl: "p://svnx/abc",        args: { dir: "/tmp/svnx-test", url: "p://svnx/abc", cls: MockCommandLine } }
    ].each do |args|
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
      { exp: "/tmp/svnx-test", args: { dir: "/tmp/svnx-test",   cls: MockCommandLine } }, 
      { exp: "p://svnx/abc",   args: { url: "p://svnx/abc" } }, 
      # url takes priority when both are specified:
      { exp: "p://svnx/abc",   args: { dir: "/tmp/svnx-test",   url: "p://svnx/abc" } }
    ].each do |args|
      exp  = args[:exp]
      proj = Svnx::Project.new args[:args]
      
      assert_equal exp, proj.where, "args: #{args}"
    end  

    # command delegation

    param_test [
      :info,
      :update,
      :merge,
      #$$$ not enabled because commit validates options, and cls and url are not valid for it:
      # :commit,
      :log,
      :diff,
      :propset,
      :propget,
    ].each do |meth|
      MockCommandLine::ELEMENTS.clear
      proj = Svnx::Project.new dir: "/tmp/svnx-test", cls: MockCommandLine
      proj.send meth, cls: MockCommandLine
      assert_true MockCommandLine::ELEMENTS[-1].executed
      assert_equal MockCommandLine::ELEMENTS[-1].subcommand, meth.to_s
    end  
  end
end
