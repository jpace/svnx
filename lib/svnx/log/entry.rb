#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'
require 'time'
require 'svnx/log/entrypath'

module Svnx::Log
  class Entry < Svnx::Base::Entry
    attr_reader :revision, :reverse_merge, :author, :date, :paths, :msg, :entries

    def set_from_element elmt
      set_attr_var elmt, 'revision'
      @reverse_merge = attribute_value elmt, 'reverse-merge'
      
      set_elmt_vars elmt, 'author', 'date', 'msg'

      @paths = elmt.elements.to_a('paths/path').collect do |pe|
        kind = attribute_value pe, 'kind'
        action = attribute_value pe, 'action'
        name = pe.text

        EntryPath.new(kind: kind, action: Svnx::Action.new(action), name: name)
      end.sort                  # sorted, because svn is not consistent with order

      @entries = elmt.elements.to_a('logentry').collect do |le|
        Entry.new le
      end
    end

    def message
      @msg
    end

    def to_s
      [ @revision, @author, @date, @msg, @paths ].collect { |x| x.to_s }.join " "
    end

    def match action, filter
      paths.select do |path|
        path.match? action, filter
      end
    end

    def datetime
      @dt ||= DateTime.parse date
    end

    def find_paths args
      paths.select do |path|
        if args[:kind]
          path.kind == args[:kind]
        end
      end
    end
  end
end
