#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Commit
    attr_reader :revision
    attr_reader :author
    attr_reader :date
  end
  
  class WorkingCopy
    attr_reader :properties
    attr_reader :item
    attr_reader :revision
    attr_reader :commit
  end
  
  class Entry < Svnx::Base::Entry
    include Comparable
    
    attr_reader :commit_revision
    attr_reader :name
    attr_reader :path
    attr_reader :status
    attr_reader :status_revision

    def initialize xmlelement, rootpath: nil
      @rootpath = rootpath
      super xmlelement
    end

    def set_from_element elmt
      set_attr_var elmt, 'path'

      wcstatus = elmt.at_xpath 'wc-status'
      @status = Svnx::Action.new wcstatus['item']
      set_attr_var wcstatus, 'status_revision', 'revision'
      
      commit = wcstatus.at_xpath 'commit'
      set_attr_var commit, 'commit_revision', 'revision'
      @name = @path.dup

      if @rootpath
        # name is prefixed with directory unless '.' is used as the argument
        @name.sub! Regexp.new('^' + @rootpath), ''
      end
    end

    def to_s
      " #{@path}: #{@status}"
    end

    def <=> other
      path <=> other.path
    end
  end
end
