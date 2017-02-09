#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/entry'
require 'svnx/base/entries'

class Svnx::Propget::Entries < Svnx::Base::Entries
  def get_elements doc
    doc.elements['properties'].elements
  end

  def create_entry xmlelement
    Svnx::Propget::Entry.new :xmlelement => xmlelement
  end
end
