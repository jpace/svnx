#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'

module SVNx; module Info; end; end

module SVNx::Info
  class Entry < SVNx::Entry
    attr_reader :url
    attr_reader :root
    attr_reader :kind
    attr_reader :path
    attr_reader :revision
    attr_reader :wc_root

    def set_from_element elmt
      set_attr_var elmt, 'kind'
      set_attr_var elmt, 'path'
      set_attr_var elmt, 'revision'
      
      set_elmt_var elmt, 'url'
      
      repo = elmt.elements['repository']
      set_elmt_var repo, 'root'

      @wc_root = nil
      if wcinfo = elmt.elements['wc-info']
        if wcroot = wcinfo.elements['wcroot-abspath']
          @wc_root = wcroot.text
        end
      end
    end
  end
end
