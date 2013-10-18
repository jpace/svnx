#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'
require 'svnx/base/action'

module SVNx; module Log; end; end

module SVNx::Log
  class Entry < SVNx::Entry
    attr_reader :revision, :author, :date, :paths, :msg

    def set_from_element elmt
      set_attr_var elmt, 'revision'

      %w{ author date msg }.each do |field|
        set_elmt_var elmt, field
      end
      
      @paths = Array.new

      elmt.elements.each('paths/path') do |pe|
        kind = get_attribute pe, 'kind'
        action = get_attribute pe, 'action'
        name = pe.text

        @paths << LogEntryPath.new(kind: kind, action: SVNx::Action.new(action), name: name)
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
  end
  
  class LogEntryPath
    include Comparable
    
    attr_reader :kind, :action, :name
    
    def initialize args = Hash.new
      @kind = args[:kind]
      @action = args[:action]
      @name = args[:name]
    end

    def to_s
      @name
    end

    def <=> other
      name <=> other.name
    end

    def match? action, filter
      @action.to_s == action.to_s && @name.start_with?(filter)
    end
  end
end
