#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entries'
require 'svnx/log/entry'

module Svnx::Log
  class Entries < Svnx::Base::Entries
    def get_elements doc
      doc.elements['log'].elements
    end

    def create_entry xmlelement
      Entry.new xmlelement
    end

    def match action, filter
      Array.new.tap do |a|
        each do |entry|
          a.concat entry.match(action, filter)
        end
      end.sort
    end
  end
end
