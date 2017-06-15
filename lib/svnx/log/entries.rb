#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entries'
require 'svnx/log/entry'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Entries < Svnx::Base::Entries
    def get_elements doc
      doc.elements['log'].elements
    end

    def create_entry xmlelement
      Entry.new xmlelement: xmlelement
    end

    def match action, filter
      matching = Array.new
      each do |entry|
        matching.concat entry.match(action, filter)
      end
      matching.sort
    end
  end
end
