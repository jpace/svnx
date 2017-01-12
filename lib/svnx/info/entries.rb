#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/entry'
require 'svnx/base/entries'

module Svnx
  module Info
  end
end

class Svnx::Info::Entries < Svnx::Entries
  def get_elements doc
    doc.elements['info'].elements
  end

  def create_entry xmlelement
    Svnx::Info::Entry.new :xmlelement => xmlelement
  end
end
