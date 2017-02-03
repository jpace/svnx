#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/base/entries'

class Svnx::Status::Entries < Svnx::Base::Entries
  def initialize args = Hash.new
    @rootpath = args[:rootpath]
    super
  end

  def get_elements doc
    doc.elements['status'].elements['target'].elements
  end

  def create_entry xmlelement
    Svnx::Status::Entry.new xmlelement: xmlelement, rootpath: @rootpath
  end
end
