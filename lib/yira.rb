#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

class Yira
  def initialize
  end

  def my_credentials
    "jpace:H@ll0w3dB3Thy"
  end

  def get_url url
    args = Array.new
    args << "curl"
    args << "-k"
    args << "-u"
    args << qq(my_credentials)
    args << "-X"
    args << "GET"
    args << "-H"
    args << qq("Content-Type: application/json")
    args << qq(url)
    puts "args: #{args}"
    cmd = args.join " "
    puts "cmd: #{cmd}"

    contents = IO.popen(cmd).readlines.join ""

    puts "contents"
    puts contents

    json = JSON.parse contents
  end

  def q str
    "'" + str + "'"
  end

  def qq str
    '"' + str + '"'
  end
end
