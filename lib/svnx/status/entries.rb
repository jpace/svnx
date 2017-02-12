#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entry'
require 'svnx/base/entries'

class Svnx::Status::Entries < Svnx::Base::Entries
  def initialize args = Hash.new
    info "args: #{args}"
    @rootpath = args[:rootpath]
    super
  end

  def get_elements doc
    info "doc: #{doc}"
    doc.elements['status'].elements['target'].elements
  end

  def create_entry xmlelement
    info "xmlelement: #{xmlelement}"
    Svnx::Status::Entry.new xmlelement: xmlelement, rootpath: @rootpath
  end
end
