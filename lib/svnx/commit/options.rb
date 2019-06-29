#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    has_fields file: Proc.new { |x| [ "-F", x.file ] },
               paths: nil
  end
end
