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
          to_args "--file", field
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

      def to_args tagname, methname
        Proc.new { |obj| [ tagname, obj.send(methname) ] }
      end

      def to_tag sym, invoke = nil
        tag = "--" + Svnx::StringUtil.with_dashes(sym)
        if invoke
          Proc.new { |x| [ tag, x.send(sym) ] }
        else
          tag
        end
      end

      def has_tag_field name
        has_field name, to_tag(name)
      end

      def has_tag_fields(*names)
        names.each do |name|
          has_tag_field name
        end
      end

      def has_tag_argument tagname, methname
        has_field methname, to_args(tagname, methname)
      end
    end

    extend ClassMethods

    def self.included other
      other.extend ClassMethods
    end
  end
end
