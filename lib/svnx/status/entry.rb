#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Entry < Svnx::Base::Entry
    include Comparable
    
    attr_reader :status
    attr_reader :path
    attr_reader :status_revision
    attr_reader :action
    attr_reader :commit_revision
    attr_reader :name

    def initialize xmlelement, rootpath: nil
      @rootpath = rootpath
      super xmlelement
      # @status is an Svnx::Action
      @action = @status
    end

    def set_from_element elmt
      set_attr_var elmt, 'path'

      wcstatus = elmt.elements['wc-status']
      @status = Svnx::Action.new(wcstatus.attributes['item'])
      set_attr_var wcstatus, 'status_revision', 'revision'
      
      commit = wcstatus.elements['commit']
      set_attr_var commit, 'commit_revision', 'revision'
      @name = @path.dup

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
