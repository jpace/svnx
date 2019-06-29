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
               revision: Proc.new { |x| [ "--revprop", "-r", x.revision ] },
               file:     Proc.new { |x| [ "--file", x.file ] },
               value:    nil,
               url:      nil,
               path:     nil
  end
end
