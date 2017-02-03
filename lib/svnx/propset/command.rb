#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/command'

class Svnx::Propset::Command < Svnx::Base::Command
  include Svnx::Base::TextOutput
  include Svnx::Base::NonCaching
  
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
