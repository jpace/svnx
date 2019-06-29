#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    has_fields commit: Proc.new { |x| [ "-c",       x.commit ] },
               range:  Proc.new { |x| [ "-r",       x.range ]  },
               accept: Proc.new { |x| [ "--accept", x.accept ] },
               from:   nil,
               to:     nil
  end
end
