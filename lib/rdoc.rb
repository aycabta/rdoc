# frozen_string_literal: false
$DEBUG_RDOC = nil

require 'rdoc/rdoc'

require 'rdoc/test_case'

require 'rdoc/cross_reference'
require 'rdoc/erbio'
require 'rdoc/erb_partial'
require 'rdoc/encoding'
require 'rdoc/generator'
require 'rdoc/options'
require 'rdoc/parser'
require 'rdoc/servlet'
require 'rdoc/ri'
require 'rdoc/stats'
require 'rdoc/store'
require 'rdoc/task'
require 'rdoc/text'

require 'rdoc/markdown'
require 'rdoc/markup'
require 'rdoc/rd'
require 'rdoc/tom_doc'

require 'rdoc/known_classes'

require 'rdoc/ruby_lex'
require 'rdoc/ruby_token'
require 'rdoc/token_stream'

require 'rdoc/comment'

require 'rdoc/i18n'

# code objects
#
# We represent the various high-level code constructs that appear in Ruby
# programs: classes, modules, methods, and so on.
require 'rdoc/code_object'

require 'rdoc/context'
require 'rdoc/top_level'

require 'rdoc/anon_class'
require 'rdoc/class_module'
require 'rdoc/normal_class'
require 'rdoc/normal_module'
require 'rdoc/single_class'

require 'rdoc/alias'
require 'rdoc/any_method'
require 'rdoc/method_attr'
require 'rdoc/ghost_method'
require 'rdoc/meta_method'
require 'rdoc/attr'

require 'rdoc/constant'
require 'rdoc/mixin'
require 'rdoc/include'
require 'rdoc/extend'
require 'rdoc/require'

# :main: README.rdoc

##
# RDoc produces documentation for Ruby source files by parsing the source and
# extracting the definition for classes, modules, methods, includes and
# requires.  It associates these with optional documentation contained in an
# immediately preceding comment block then renders the result using an output
# formatter.
#
# For a simple introduction to writing or generating documentation using RDoc
# see the README.
#
# == Roadmap
#
# If you think you found a bug in RDoc see CONTRIBUTING@Bugs
#
# If you want to use RDoc to create documentation for your Ruby source files,
# see RDoc::Markup and refer to <tt>rdoc --help</tt> for command line usage.
#
# If you want to set the default markup format see
# RDoc::Markup@Supported+Formats
#
# If you want to store rdoc configuration in your gem (such as the default
# markup format) see RDoc::Options@Saved+Options
#
# If you want to write documentation for Ruby files see RDoc::Parser::Ruby
#
# If you want to write documentation for extensions written in C see
# RDoc::Parser::C
#
# If you want to generate documentation using <tt>rake</tt> see RDoc::Task.
#
# If you want to drive RDoc programmatically, see RDoc::RDoc.
#
# If you want to use the library to format text blocks into HTML or other
# formats, look at RDoc::Markup.
#
# If you want to make an RDoc plugin such as a generator or directive handler
# see RDoc::RDoc.
#
# If you want to write your own output generator see RDoc::Generator.
#
# If you want an overview of how RDoc works see CONTRIBUTING
#
# == Credits
#
# RDoc is currently being maintained by Eric Hodel <drbrain@segment7.net>.
#
# Dave Thomas <dave@pragmaticprogrammer.com> is the original author of RDoc.
#
# * The Ruby parser in rdoc/parse.rb is based heavily on the outstanding
#   work of Keiju ISHITSUKA of Nippon Rational Inc, who produced the Ruby
#   parser for irb and the rtags package.

module RDoc

  ##
  # Exception thrown by any rdoc error.

  class Error < RuntimeError; end

  ##
  # RDoc version you are using

  VERSION = '5.1.0'

  ##
  # Method visibilities

  VISIBILITIES = [:public, :protected, :private]

  ##
  # Name of the dotfile that contains the description of files to be processed
  # in the current directory

  DOT_DOC_FILENAME = ".document"

  ##
  # General RDoc modifiers

  GENERAL_MODIFIERS = %w[nodoc].freeze

  ##
  # RDoc modifiers for classes

  CLASS_MODIFIERS = GENERAL_MODIFIERS

  ##
  # RDoc modifiers for attributes

  ATTR_MODIFIERS = GENERAL_MODIFIERS

  ##
  # RDoc modifiers for constants

  CONSTANT_MODIFIERS = GENERAL_MODIFIERS

  ##
  # RDoc modifiers for methods

  METHOD_MODIFIERS = GENERAL_MODIFIERS +
    %w[arg args yield yields notnew not-new not_new doc]

  ##
  # Loads the best available YAML library.

  def self.load_yaml
    begin
      gem 'psych'
    rescue NameError => e # --disable-gems
      raise unless e.name == :gem
    rescue Gem::LoadError
    end

    begin
      require 'psych'
    rescue ::LoadError
    ensure
      require 'yaml'
    end
  end

end
