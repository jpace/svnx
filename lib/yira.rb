#!/usr/bin/ruby -w
# -*- ruby -*-

require 'json'

class Yira
  def initialize
  end

  def my_credentials
    "jpace:H@ll0w3dB3Thy"
  end

  def run_curl type, *params
    args = Array.new
    args << "curl"
    args << "-k"
    args << "-u"
    args << qq(my_credentials)
    args << "-X"
    args << type
    args << "-H"
    args << qq("Content-Type: application/json")
    args.concat params
    cmd = args.join " "
    puts "cmd: #{cmd}"

    contents = IO.popen(cmd).readlines.join ""

    puts "contents"
    # puts contents

    JSON.parse contents
  end

  def get_url url
    run_curl "GET", url
  end

  def post_url data, url
    run_curl "POST", "--data", q(data), url
  end

  def q str
    "'" + str + "'"
  end

  def qq str
    '"' + str + '"'
  end
end
