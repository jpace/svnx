#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/action'

module Svnx
  module Log
  end
end

module Svnx::Log
  class EntryPath
    include Comparable
    
    attr_reader :kind, :action, :name, :prop_mods, :text_mods
    
    def initialize attr: nil, kind: nil, action: nil, name: nil, prop_mods: nil, text_mods: nil
      if attr
        @kind = attribute_value attr, 'kind'
        act = attribute_value attr, 'action'
        @action = Svnx::Action.new act
        @name = attr.text
        @prop_mods = "true" == attribute_value(attr, 'prop-mods')
        @text_mods = "true" == attribute_value(attr, 'text-mods')
      else
        @kind = kind
        @action = action
        @name = name
        @prop_mods = prop_mods
        @text_mods = text_mods
      end
    end

    def to_s
      @name
    end

    def inspect
      to_s
    end

    def <=> other
      name <=> other.name
    end

    def match? action, filter
      @action.to_s == action.to_s && @name.start_with?(filter)
    end

    def attribute_value xmlelement, attrname, meth = nil
      value = xmlelement[attrname.to_s]
      meth ? value.send(meth) : value
    end    
  end
end
