#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

class Svnx::Info::Command < Svnx::Base::Command
  include Svnx::Base::NonCaching
  include Svnx::Base::XmlOutput
  
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    info "@output: #{@output}"
    
    unless @output.empty?
      @entries = Svnx::Info::Entries.new xmllines: @output
    end
  end
end
