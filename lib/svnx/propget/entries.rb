#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/entry'
require 'svnx/base/entries'

module Svnx::Propget
  class Entries < Svnx::Base::Entries
    def get_elements doc
      doc.xpath '//properties/target'
    end

    def create_entry xmlelement
      Entry.new xmlelement
    end
  end
end
