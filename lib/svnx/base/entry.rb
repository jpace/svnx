#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'logue/loggable'

module Svnx
  module Base
  end
end

class Svnx::Base::Entry
  include Logue::Loggable

  def initialize args
    if args.has_key? :xmllines
      if xmllines = args[:xmllines]
        if xmllines.kind_of? Array
          xmllines = xmllines.join ''
        end

        doc = REXML::Document.new xmllines

        set_from_xml doc
      else
        raise "xmllines should not be nil"
      end
    elsif args.has_key? :xmlelement
      if elmt = args[:xmlelement]
        set_from_element elmt
      else
        raise "xmlelement should not be nil"
      end
    else
      raise "must be initialized with xmllines or xmlelement (args.keys: #{args.keys.sort})"
    end
  end

  def set_from_xml xmldoc
    raise "must be implemented"
  end

  def set_from_element elmt
    raise "must be implemented"
  end

  def get_attribute xmlelement, attrname
    xmlelement.attributes[attrname]
  end

  def get_element_text xmlelement, elmtname
    elmt = xmlelement.elements[elmtname]
    # some elements don't have text:
    (elmt && elmt.text) || ""
  end

  def set_attr_var xmlelement, varname
    set_var varname, get_attribute(xmlelement, varname)
  end

  def set_attr_vars xmlelement, *varnames
    varnames.each do |varname|
      set_attr_var xmlelement, varname
    end
  end

  def set_elmt_var xmlelement, varname
    set_var varname, get_element_text(xmlelement, varname)
  end

  def set_elmt_vars xmlelement, *varnames
    varnames.each do |varname|
      set_elmt_var xmlelement, varname
    end
  end

  def set_var varname, value
    instance_variable_set '@' + varname, value
  end
end
