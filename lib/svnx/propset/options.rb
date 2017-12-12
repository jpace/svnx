#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propset
  end
end

module Svnx::Propset
  class Options < Svnx::Base::Options
    FIELDS = [ :name, :revision, :file, :value, :url, :path ]
    
    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :revision
        [ "--revprop", "-r", revision ] 
      when :file
        [ "--file", file ] 
      else
        send field
      end
    end
  end
end
