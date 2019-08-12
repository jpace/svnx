#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    has_fields commit: to_args("-c", :commit),
               range:  to_args("-r", :range),
               accept: to_args("--accept", :accept),
               from:   nil,
               to:     nil
  end
end
