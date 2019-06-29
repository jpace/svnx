#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Options < Svnx::Base::Options
    has_fields revision: Svnx::Base::REVISION_FIELD,
               paths:    nil,
               url:      nil
  end
end
