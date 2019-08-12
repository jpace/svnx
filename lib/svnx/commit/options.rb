#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    has :file, :paths
    has_fields with_revprop: to_args("--with-revprop", :with_revprop)
  end
end
