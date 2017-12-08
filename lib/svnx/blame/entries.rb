#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/entry'
require 'svnx/base/entries'

module Svnx::Blame
  class Entries < Svnx::Base::Entries
    def initialize args = Hash.new
      @rootpath = args[:rootpath]
      super
    end

    def get_elements doc
      # blame/target
      doc.elements['blame'].elements['target'].elements
    end

    def create_entry xmlelement
      Entry.new xmlelement: xmlelement, rootpath: @rootpath
    end
  end
end
