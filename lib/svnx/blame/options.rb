#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :paths, :urls ]
    
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
