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
    attr_reader :commit_revision
    attr_reader :commit_author
    attr_reader :commit_date
    
    def initialize xmlelement: nil
      super xmlelement: xmlelement
    end

    def set_from_element elmt
      @line_number = elmt.attributes['line-number']
      
      if commit = elmt.elements['commit']
        @commit_revision = commit.attributes['revision'].to_i
        @commit_author   = commit.elements['author'].text
        datestr          = commit.elements['date'].text
        @commit_date     = DateTime.parse(datestr).to_time
      else
        @commit_revision = nil
        @commit_author   = nil
        @commit_date     = nil
      end
    end

    def <=> other
      line_number <=> other.line_number
    end
  end
end
