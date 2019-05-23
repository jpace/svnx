#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/entry'
require 'svnx/base/entries'

module Svnx::Blame
  class Entries < Svnx::Base::Entries
    def get_elements doc
      # blame/target
      doc.xpath '//blame/target/entry'
    end

    def create_entry xmlelement
      Entry.new xmlelement
    end
  end
end
