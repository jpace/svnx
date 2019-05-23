#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'time'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Entry < Svnx::Base::Entry
    include Comparable
    
    attr_reader :line_number
    attr_reader :revision
    attr_reader :author
    attr_reader :date
    
    def set_from_element elmt
      set_attr_var elmt, 'line_number', 'line-number'
      
      commit = elmt.at_xpath 'commit'
      set_attr_var commit, 'revision'
      set_elmt_vars commit, 'author', 'date'
    end

    def set_commit_fields rev, auth, date
      @commit_revision = rev
      @commit_author   = auth
      @commit_date     = date
    end

    def <=> other
      line_number <=> other.line_number
    end

    def datetime
      @dt ||= DateTime.parse date
    end
  end
end
