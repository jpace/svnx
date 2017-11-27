#!/usr/bin/ruby -w
# -*- ruby -*-

class ClassUtil
  class << self
    def module_elements cls
      mods = cls.name.split "::"
      mods[0 .. -2]
    end

    def find_module cls
      mod = module_elements(cls) * "::"
      Kernel.const_get mod
    end
  end
end
