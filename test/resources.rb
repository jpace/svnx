#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'singleton'

class SvnResource
  include Logue::Loggable

  RES_DIR = (Pathname.pwd + 'test/resources/').to_s
  
  def initialize dir, cmd, args = Array.new
    @dir = dir
    @cmd = [ 'svn', cmd, '--xml' ] + args
  end

  def to_path
    RES_DIR + @dir.sub(%r{^/}, '').gsub('/', '_') + '__' + @cmd.join('_').gsub('/', '__')
  end

  def readlines
    ::IO.readlines to_path
  end

  def generate
    origdir  = Pathname.new(Dir.pwd).expand_path
    tgtdir   = RES_DIR
    svncmd   = @cmd.join(' ')
    outfname = @dir.sub(%r{^/}, '').gsub('/', '_') + '__' + @cmd.join('_').gsub(' ', '_').gsub('/', '__')
    outfile  = tgtdir + outfname

    Dir.chdir @dir
    
    IO.popen(svncmd) do |svnio|
      lines = svnio.readlines
      File.open(outfile, "w") do |fio|
        fio.puts lines
      end
    end
    Dir.chdir origdir.to_s
  end
end

class PtSvnResource < SvnResource
  def initialize cmd, *args
    super '/Programs/pvn/pvntestbed.from', cmd, args
  end
end

class PtPendingSvnResource < SvnResource
  def initialize cmd, *args
    super '/Programs/pvn/pvntestbed.pending', cmd, args
  end
end

class Resources
  include Singleton

  PT_PATH = '/Programs/pvn/pvntestbed'
  
  PT_LOG_R19  = PtSvnResource.new 'log', '-r19' # empty message

  PT_LOG_R19_5 = PtSvnResource.new 'log', '-r19:5'

  # these are the equivalent of limits of 1, 5, 7, and 19, starting at revision 19

  # PT_LOG_R19_19 == PT_LOG_R19

  PT_LOG_R19_15 = PtSvnResource.new 'log', '-r19:15'
  PT_LOG_R19_13 = PtSvnResource.new 'log', '-r19:13'
  PT_LOG_R19_1  = PtSvnResource.new 'log', '-r19:1'

  PT_LOG_R19_1_V = PtSvnResource.new 'log', '-r19:1', '-v'

  # pt.pending needs to be checked out from pt.from, then
  # bin/change.rb should be executed.
  
  def generate
    # puts "this: #{self.class.constants}"
    self.class.constants.each do |con|
      # puts "con: #{con}"
      res = self.class.const_get con
      # puts "res: #{res}"
      next unless res.respond_to? :generate
      res.generate
    end
  end
end

if __FILE__ == $0
  if ARGV[0] == 'generate'
    Resources.instance.generate
  end
end
