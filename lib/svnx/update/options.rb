#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Update
  end
end

module Svnx::Update
  class Options < Svnx::Base::Options
    has_fields revision: Svnx::Base::REVISION_FIELD,
               paths: nil
  end
end
