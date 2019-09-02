#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    has_tag_argument :change, :revision, :accept
    has_fields from: nil,
               to:   nil
  end
end
