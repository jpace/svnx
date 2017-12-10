#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/base/entries'

module Svnx::Status
  class Entries < Svnx::Base::Entries
    def initialize lines, rootpath: nil
      @rootpath = rootpath
      super lines
    end

    def get_elements doc
      # status/target
      doc.elements['status'].elements['target'].elements
    end

    def create_entry xmlelement
      Entry.new xmlelement, rootpath: @rootpath
    end
  end
end
