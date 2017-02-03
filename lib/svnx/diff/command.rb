#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/command'
require 'svnx/diff/parser'

class Svnx::Diff::Command < Svnx::Base::Command
  include Svnx::Base::Caching
  include Svnx::Base::XmlOutput
  
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    debug "output: #{@output}"
    if @output
      @entries = Svnx::Diff::Parser.new.parse_all_output @output.dup
    end
  end
end
