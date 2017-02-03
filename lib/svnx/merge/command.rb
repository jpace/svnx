#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/base/command'

class Svnx::Merge::Command < Svnx::Base::Command
  include Svnx::Base::NonCaching
  include Svnx::Base::TextOutput
  
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
