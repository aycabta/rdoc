# frozen_string_literal: false
require 'rdoc'

require 'rdoc/ri/driver'
require 'rdoc/ri/paths'
require 'rdoc/ri/store'

##
# Namespace for the ri command line tool's implementation.
#
# See <tt>ri --help</tt> for details.

module RDoc::RI

  ##
  # Base RI error class

  class Error < RDoc::Error; end

end

