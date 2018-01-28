#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    FIELDS = Svnx::Base::REVISION_PATHS_URLS_FIELDS.merge(Svnx::Base::IGNORE_WHITESPACE)
    
    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
