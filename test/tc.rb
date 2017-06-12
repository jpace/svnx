require 'logue/log'
require 'stringio'
require 'test/unit'
require 'resources'
require 'rainbow'

# no verbose if running all tests:
level = ARGV.detect { |x| x.index '**' } ? Logue::Log::WARN : Logue::Log::DEBUG

puts "1 ARGV: #{ARGV}"
puts "1 level: #{level}"
puts "Logue::Log::WARN: #{Logue::Log::WARN}"

Logue::Log.level = level
Logue::Log.set_widths(-35, 4, -35)

Logue::Log.stack "3 ARGV: #{ARGV}"

puts "2 ARGV: #{ARGV}"
puts "2 level: #{level}"

# produce colorized output, even when redirecting to a file:
Rainbow.enabled = true

module Svnx
end

class Svnx::TestCase < Test::Unit::TestCase
  include Logue::Loggable
  
  def setup
  end
end
