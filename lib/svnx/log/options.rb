#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Options < Svnx::Base::Options
    has_fields limit:    Proc.new { |x| [ "--limit", x.limit ] },
               verbose:  "-v",

               revision: Proc.new { |x| "-r" + x.revision.to_s }
    has :url, :path
  end
end
