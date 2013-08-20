#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/entry'
require 'svnx/action'

module SVNx; module Status; end; end

module SVNx::Status
  class Entry < SVNx::Entry
    attr_reader :status
    attr_reader :path
    attr_reader :status_revision
    attr_reader :action
    attr_reader :commit_revision

    def initialize args
      super
      @action = SVNx::Action.new @status
    end

    def set_from_element elmt
      set_attr_var elmt, 'path'

      wcstatus = elmt.elements['wc-status']
      @status = wcstatus.attributes['item']
      @status_revision = wcstatus.attributes['revision']
      
      commit = wcstatus.elements['commit']
      @commit_revision = commit && commit.attributes['revision']
    end

    def to_s
      "path: #{@path}; status: #{@status}"
    end
  end
end
