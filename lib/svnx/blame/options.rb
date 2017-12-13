#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    has_fields Svnx::Base::REVISION_PATHS_URLS_FIELDS.keys

    def fields
      Svnx::Base::REVISION_PATHS_URLS_FIELDS
    end
  end
end
