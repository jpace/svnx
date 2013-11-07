#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'

module SVNx; module Status; end; end

module SVNx::Status
  class Entry < SVNx::Entry
    include Comparable, Logue::Loggable
    
    attr_reader :status
    attr_reader :path
    attr_reader :status_revision
    attr_reader :action
    attr_reader :commit_revision
    attr_reader :name

    def initialize args
      @rootpath = args[:rootpath]
      super
      @action = SVNx::Action.new @status
    end

    def set_from_element elmt
      set_attr_var elmt, 'path'

      wcstatus = elmt.elements['wc-status']
      @status = SVNx::Action.new(wcstatus.attributes['item'])
      @status_revision = wcstatus.attributes['revision']
      
      commit = wcstatus.elements['commit']
      @commit_revision = commit && commit.attributes['revision']
      @name = @path.dup

      info "@name: #{@name}"
      info "@path: #{@path}"
      info "@rootpath: #{@rootpath}"

      if @rootpath
        # name is prefixed with directory unless '.' is used as the argument
        @name.sub! Regexp.new('^' + @rootpath), ''
      end
    end

    def to_s
      "path: #{@path}; status: #{@status}"
    end

    def <=> other
      path <=> other.path
    end
  end
end
