#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/io/element'

module SVNx::IO
  class ElementTestCase < SVNx::IntegrationTestCase
    def test_init
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      info "el: #{el}"
      assert_equal '/Programs/pvn/pvntestbed.pending', el.local.to_path
    end

    def test_exists
      el = Element.new local: '/Programs/pvn/pvntestbed.pending'
      info "el: #{el}"
      assert el.exist?
    end

    def test_does_not_exist
      el = Element.new local: '/Programs/pvn/nosuchdirectory'
      info "el: #{el}"
      assert !el.exist?
    end

    def test_is_directory
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/text'
      info "el: #{el}"
      assert el.directory?
    end

    def test_is_not_directory
      el = Element.new local: '/Programs/pvn/pvntestbed.pending/FirstFile.txt'
      info "el: #{el}"
      assert !el.directory?
    end
  end
end
