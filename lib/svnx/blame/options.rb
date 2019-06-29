#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    has_fields
    
    has_revision
    has_paths
    has_urls
    has_ignore_whitespace
  end
end
