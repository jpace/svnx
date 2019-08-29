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
    has_tag_arguments :with_revprop, :message, :username, :password
  end
end
