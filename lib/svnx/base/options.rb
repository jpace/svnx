#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Options
    include Svnx::ObjectUtil

    class << self
      def has_revision
        has_field :revision, Proc.new { |x| [ "-r", x.revision ] }
      end

      def has_ignore_whitespace
        has_field :ignorewhitespace, %w{ -x -bw -x --ignore-eol-style }
      end

      def has_paths
        has_field :paths, nil
      end

      def has_path
        has_field :path, nil
      end

      def has_urls
        has_field :urls, nil
      end

      def has_url
        has_field :url, nil
      end
    end

    def initialize args
      fkeys = fields.keys
      
      assign args, fkeys
      validate args, fkeys
    end
    
    def options_to_args
      fields.keys.collect do |fld|
        [ fld, get_args(fld) ]
      end
    end

    def fields
      raise "not implemented for #{self.class}"
    end
    
    def to_args
      options_to_args.collect do |opt|
        send(opt.first) ? opt[1] : nil
      end.compact.flatten
    end

    def get_args field
      val = fields[field]
      case val
      when Proc
        val.call self
      when nil
        send field
      else
        val
      end
    end    
  end
end
