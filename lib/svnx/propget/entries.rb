#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/entry'
require 'svnx/base/entries'

module Svnx::Propget
  class Entries < Svnx::Base::Entries
    def get_elements doc
      doc.elements['properties'].elements
    end

    def create_entry xmlelement
      Entry.new :xmlelement => xmlelement
    end
  end
end
