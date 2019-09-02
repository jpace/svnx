#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/strutil'

module Svnx::Base
  module Tags
    module ClassMethods
      # common options/tags
      def mapping field
        case field
        when :revision
          to_args "-r", field
        when :ignore_whitespace
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
          to_args "--file", field
        else
          raise "invalid field '#{field}'"
        end
      end

      # for common options/tags
      def has(*fields)
        fields.each do |field|
          arg = mapping field
          has_field field, arg
        end
      end

      # gets the value for the tag/option by calling methname
      def to_args tagname, methname
        Proc.new { |obj| [ tagname, obj.send(methname) ] }
      end

      # converts the symbol to a tag
      def to_tag sym
        "--" + Svnx::StringUtil.with_dashes(sym)
      end

      # tags with no argument
      def has_tag_field(*names)
        has_tags(false, *names)
      end

      # tags with an argument
      def has_tag_argument(*names)
        has_tags(true, *names)
      end

      # tags with an argument
      def has_tags(argument, *names)
        names.each do |name|
          tag = to_tag name
          value = argument ? to_args(tag, name) : tag
          has_field name, value
        end
      end
    end

    extend ClassMethods

    def self.included other
      other.extend ClassMethods
    end
  end
end
