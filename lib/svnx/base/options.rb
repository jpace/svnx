#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'svnx/util/strutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Options
    include Svnx::ObjectUtil

    class << self
      def mapping field
        case field
        when :revision
          Proc.new { |x| [ "-r", x.send(:revision) ] }
        when :ignorewhitespace, :ignore_whitespace
          %w{ -x -bw -x --ignore-eol-style }
        when :paths
          nil
        when :path
          nil
        when :urls
          nil
        when :url
          nil
        when :file
          Proc.new { |x| [ "--file", x.file ] }
        else
          raise "invalid field '#{field}'"
        end
      end

      def has(*fields)
        fields.each do |field|
          arg = mapping field
          has_field field, arg
        end
      end

      def to_tag sym, invoke = nil
        tag = "--" + StringUtil.with_dashes(sym)
        if invoke
          Proc.new { |x| [ tag, x.send(sym) ] }
        else
          tag
        end
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
