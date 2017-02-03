#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'

class Svnx::Status::Command < Svnx::Base::Command
  include Svnx::Base::NonCaching
  include Svnx::Base::XmlOutput
  
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute

    if not @output.empty? 
      @entries = Svnx::Status::Entries.new xmllines: @output
    end
  end
end
