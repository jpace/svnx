#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/log/command'
require 'svnx/status/command'
require 'svnx/info/command'
require 'svnx/cat/command'
require 'pathname'

module Svnx
  module IO
  end
end

# An element unites an svn element and a file/directory (at least one of
# which should exist).

module Svnx::IO
  class Element
    include Logue::Loggable, Comparable

    attr_reader :svn
    attr_reader :path
    attr_reader :local
    
    def initialize args = Hash.new
      info "args: #{args.inspect}".color("438802")
      
      # svnurl = args[:svnurl]
      # fname  = args[:filename] || args[:file] # legacy
      # $$$ todo: map svnurl to SVNElement, and fname to FSElement

      @svn   = args[:svn] # || (args[:file] && SVNElement.new(:filename => args[:file]))
      @local = args[:local] && Pathname.new(args[:local]) # && PVN::FSElement.new(args[:local] || args[:file])
      @path  = args[:path]
      
      info "local: #{@local.inspect}"
    end

    def exist?
      @local && @local.exist?
    end

    def directory?
      @local && @local.directory?
    end

    def file?
      @local && @local.file?
    end

    def get_info revision = nil
      return nil unless in_svn?
      
      usepath = @local ? @local.to_path : @path
      inf = Svnx::Info::Command.new url: usepath, revision: revision
      inf.entry
    end

    def in_svn?
      # svn status can only be a local path:
      if @local
        st = Svnx::StatusExec.new path: @local.to_path
        st.entries.size == 0 || st.entries[0].status.to_s != 'unversioned'
      else
        raise "cannot determine svn status without a local path; only target '#{@path}' defined"
      end
    end

    def find_entries args = Hash.new
      revision = args[:revision]
      status = args[:status]
      
      if revision.nil?
        find_by_status status
      else
        find_in_log revision, status
      end
    end

    def find_in_log revision, action
      svninfo = get_info

      filter = svninfo.url.dup
      filter.slice! svninfo.root

      # we can't cache this, because we don't know if there has been an svn
      # update since the previous run:
      logexec = Svnx::LogExec.new path: @local, revision: revision, verbose: true, use_cache: false
      entries = logexec.entries
      
      act = action.kind_of?(Svnx::Action) ? action : Svnx::Action.new(action)
      entries.match act, filter
    end

    def find_by_status status
      statexec = Svnx::StatusExec.new path: @local, use_cache: false
      entries = statexec.entries

      entries.select do |entry|
        status.nil? || entry.status.to_s == status.to_s
      end.sort
    end

    def log_entries args = Hash.new
      rev = args[:revision]
      # use_cache should be conditional on revision:
      logexec = Svnx::LogExec.new :path => @local, :revision => rev && rev.to_s, :verbose => true, :use_cache => false
      logexec.entries
    end

    def cat args = Hash.new
      rev = args[:revision]
      catexec = Svnx::CatExec.new :path => @local, :revision => rev && rev.to_s, :use_cache => false
      catexec.output
    end

    def to_s
      "svn => " + @svn.to_s + "; local => " + @local.to_s
    end

    def <=> other
      @local <=> other.local
    end
  end
end
