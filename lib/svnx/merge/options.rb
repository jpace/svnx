#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    FIELDS = Hash.new.tap do |h|
      h[:commit] = Proc.new { |x| [ "-c",       x.commit ] }
      h[:range]  = Proc.new { |x| [ "-r",       x.range ]  }
      h[:accept] = Proc.new { |x| [ "--accept", x.accept ] }
      h[:from]   = nil
      h[:to]     = nil
    end
    
    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
