#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Cat
  end
end

module Svnx::Cat
  class Options < Svnx::Base::Options
    has_fields
    
    has_revision
    has_path
    has_url
  end
end
