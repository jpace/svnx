#!/usr/bin/ruby -w
# -*- ruby -*-

require 'json'
require 'logue/loggable'

class Yira
  include Logue::Loggable
  
  def initialize
  end

  def my_credentials
    ENV["YIRA_CREDENTIALS"]
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
    info "cmd: #{cmd}"

    contents = IO.popen(cmd).readlines.join ""

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
