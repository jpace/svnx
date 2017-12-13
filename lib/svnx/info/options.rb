#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Info
  end
end

module Svnx::Info
  class Options < Svnx::Base::Options
    FIELDS = Hash.new.tap do |h|
      h[:revision] = Svnx::Base::REVISION_FIELD
      h[:path]     = nil
      h[:url]      = nil
    end
    
    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
