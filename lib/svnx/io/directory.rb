#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  module IO
  end
end


# An element unites an svn element and a file/directory (at least one of
# which should exist).

module Svnx::IO
  class Directory < Element
  end
end
