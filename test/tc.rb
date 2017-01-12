require 'rubygems'
require 'logue/log'
require 'stringio'
require 'test/unit'
require 'resources'
require 'rainbow'

# no verbose if running all tests:
level = ARGV.detect { |x| x.index '**' } ? Logue::Log::WARN : Logue::Log::DEBUG

puts "ARGV: #{ARGV}"
puts "level: #{level}"

Logue::Log.level = Logue::Log::DEBUG
Logue::Log.set_widths(-35, 4, -35)

# produce colorized output, even when redirecting to a file:
Rainbow.enabled = true

module Svnx
  class TestCase < Test::Unit::TestCase
    include Logue::Loggable
    
    def setup
      info "self: #{self}"
    end
  end
end
