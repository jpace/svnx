#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Options < Svnx::Base::Options
    has_fields
    
    has_revision
    has_paths
    has_url
  end
end
