#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    FIELDS = [ :file, :paths ]

    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :file
        [ "-F", file ]
      else
        send field
      end
    end  
  end
end
