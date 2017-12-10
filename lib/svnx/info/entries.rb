#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/entry'
require 'svnx/base/entries'

module Svnx::Info
  class Entries < Svnx::Base::Entries
    def get_elements doc
      doc.elements['info'].elements
    end

    def create_entry xmlelement
      Entry.new xmlelement
    end
  end
end
