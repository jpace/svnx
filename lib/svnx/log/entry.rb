#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'
require 'time'
require 'svnx/log/entrypath'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Entry < Svnx::Base::Entry
    attr_reader :revision, :author, :date, :paths, :msg

    def set_from_element elmt
      set_attr_var elmt, 'revision'
      set_elmt_vars elmt, 'author', 'date', 'msg'
      
      @paths = Array.new

      elmt.elements.each('paths/path') do |pe|
        kind = attribute_value pe, 'kind'
        action = attribute_value pe, 'action'
        name = pe.text

        @paths << EntryPath.new(kind: kind, action: Svnx::Action.new(action), name: name)
      end
      
      # Svn isn't consistent with the order of paths
      @paths.sort!
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
