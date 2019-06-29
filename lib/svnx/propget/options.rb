#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options    
    has_fields revision: Svnx:: Base::REVISION_FIELD,
               revprop:  "--revprop",
               name:     nil,
               url:      nil,
               path:     nil
  end
end
