#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'

module Svnx
  module Info
  end
end

module Svnx::Info
  class Entry < Svnx::Base::Entry
    attr_reader :url
    attr_reader :root
    attr_reader :kind
    attr_reader :path
    attr_reader :revision
    attr_reader :wc_root
    attr_reader :relative_url

    def set_from_element elmt
      set_attr_vars elmt, 'kind', 'path', 'revision'
      set_elmt_var  elmt, 'url'
      if relurl = elmt.at_xpath('relative-url')
        @relative_url = relurl.text
      end
      
      repo = elmt.at_xpath 'repository'
      set_elmt_var repo, 'root'

      @wc_root = nil
      if wcinfo = elmt.at_xpath('wc-info')
        if wcroot = wcinfo.at_xpath('wcroot-abspath')
          @wc_root = wcroot.text
        end
      end
    end
  end
end
