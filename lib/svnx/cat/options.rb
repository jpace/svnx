#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Cat
  end
end

module Svnx::Cat
  class Options < Svnx::Base::Options
    has_fields revision: Svnx::Base::REVISION_FIELD,
               path: nil,
               url: nil
  end
end
