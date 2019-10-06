#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Entry
    include Logue::Loggable

    def initialize xmlelement
      set_from_element xmlelement
    end

    def set_from_element elmt
      raise "must be implemented"
    end

    def set_attr_var xmlelement, varname, attrname = varname, convert: nil
      value = if xmlelement
                val = attribute_value xmlelement, attrname
                if convert
                  val = val.send convert
                end
                val
              else
                nil
              end
      
      set_var varname, value
    end

    def set_attr_vars xmlelement, *varnames
      varnames.each do |varname|
        set_attr_var xmlelement, varname
      end
    end

    def set_elmt_var xmlelement, varname
      set_var varname, xmlelement && element_text(xmlelement, varname)
    end

    def set_elmt_vars xmlelement, *varnames
      varnames.each do |varname|
        set_elmt_var xmlelement, varname
      end
    end

    def set_var varname, value
      instance_variable_set '@' + varname.to_s, value
    end

    def attribute_value xmlelement, attrname
      xmlelement[attrname.to_s]
    end

    def element_text xmlelement, elmtname
      elmt = xmlelement.at_xpath elmtname.to_s
      elmt && elmt.text || ""
    end  
  end
end
