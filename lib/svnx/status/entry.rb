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

    def initialize elmt
      rev = elmt['revision']
      @revision = rev.nil? ? rev : rev.to_i
      @author = elmt.at_xpath('author').text
      @date = elmt.at_xpath('date').text
    end
  end
  
  class WorkingCopy
    attr_reader :properties
    attr_reader :status
    attr_reader :revision
    attr_reader :commit

    def initialize wcstatus
      @properties = wcstatus['props']
      @status = Svnx::Action.new wcstatus['item']
      @revision = (n = wcstatus['revision']) && n.to_i
      commit = wcstatus.at_xpath 'commit'
      @commit = commit && Commit.new(commit)
    end
  end
  
  class Entry < Svnx::Base::Entry
    include Comparable
    
    attr_reader :name
    attr_reader :path
    attr_reader :working_copy

    def initialize xmlelement, rootpath: nil
      @rootpath = rootpath
      super xmlelement
    end

    def set_from_element elmt
      set_attr_var elmt, 'path'
      wcstatus = elmt.at_xpath 'wc-status'
      
      @name = @path.dup

      @working_copy = WorkingCopy.new wcstatus

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
