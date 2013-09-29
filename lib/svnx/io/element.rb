#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rubygems'
require 'logue/loggable'
require 'svnx/log/entries'
require 'svnx/status/entries'
require 'svnx/status/command'
require 'svnx/info/entries'
require 'svnx/info/command'
require 'pathname'

module SVNx; module IO; end; end

module SVNx::IO
  # An element unites an svn element and a file/directory (at least one of
  # which should exist).

  class Element
    include Logue::Loggable

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
      inf = SVNx::InfoExec.new path: usepath, revision: revision
      inf.entry
    end

    def in_svn?
      usepath = @local ? @local.to_path : @path
      st = SVNx::StatusExec.new path: usepath
      st.entries.size == 0 || st.entries[0].status != 'unversioned'
    end
  end
end