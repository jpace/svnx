#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Cat
  end
end

module Svnx::Cat
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :path, :url ]
    
    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :revision
        [ "-r", revision ] 
      else
        send field
      end
    end
  end
end
