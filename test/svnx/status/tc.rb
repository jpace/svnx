#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'

module Svnx
  module Status
  end
end

module Svnx::Status
  class TestCase < Svnx::TestCase
    def find_subelement_by_name elmt, name
      subelmt = elmt.elements.detect { |el| el.name == name }
      subelmt ? subelmt.get_text.to_s : nil
    end

    def assert_status_entry_equals exp_status, exp_path, entry
      assert_equal exp_status.to_s, entry.status.to_s
      assert_equal exp_path, entry.path
    end
  end
end
