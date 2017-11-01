#!/usr/bin/ruby -w
# -*- ruby -*-

module ClassUtil
  module Util
    def module_elements cls
      mods = cls.name.split "::"
      mods[0 .. -2]
    end

    def find_module cls
      mod = module_elements(cls) * "::"
      Kernel.const_get mod
    end

    module_function :module_elements
    module_function :find_module
  end
end
