#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propset
  end
end

module Svnx::Propset
  class Options < Svnx::Base::Options
    has_fields name:     nil,
               revision: Proc.new { |x| [ "--revprop", "-r", x.send(:revision) ] }
    has :file
    has_fields value: nil
    has :url, :path
  end
end
