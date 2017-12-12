#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    # FIELDS = [ :commit, :range, :accept, :from, :path, :url ]
    FIELDS = [ :commit, :range, :accept, :from, :to ]
    
    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :commit
        [ "-c",       commit ] 
      when :range
        [ "-r",       range ] 
      when :accept
        [ "--accept", accept ] 
      else
        send field
      end
    end    
  end
end
