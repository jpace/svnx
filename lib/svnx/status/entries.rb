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

    def xpath
      '//status/target/entry'
    end

    def get_elements doc
      if $use_nokogiri
        doc.xpath xpath
      else
        # status/target
        doc.elements['status'].elements['target'].elements
      end
    end

    def create_entry xmlelement
      Entry.new xmlelement, rootpath: @rootpath
    end
  end
end
