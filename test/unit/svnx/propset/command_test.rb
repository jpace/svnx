#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Propset::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Propset::CommandLine

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Propset::Command.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, Svnx::Propset::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
