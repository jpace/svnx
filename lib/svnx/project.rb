#!/usr/bin/ruby -w
# -*- ruby -*-

$stderr.puts "Svnx::Project deprecated for naming; use Svnx::Exec instead"

require 'svnx/exec'

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project < Svnx::Exec
end

