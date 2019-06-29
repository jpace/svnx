#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options    
    has_fields revprop: "--revprop", name: nil

    has_revision
    has_url
    has_path
  end
end
