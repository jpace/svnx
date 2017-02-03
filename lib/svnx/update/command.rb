#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/update/options'

class Svnx::Update::Command < Svnx::Base::Command
  include Svnx::Base::TextOutput
  include Svnx::Base::NonCaching
  
  attr_reader :output

  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
