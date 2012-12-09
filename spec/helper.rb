unless Object.const_defined? 'Pry'
  $:.unshift File.expand_path '../../lib', __FILE__
  require 'pry'
end

require 'mocha/api'

require 'pry/test/helper'

require File.expand_path('../helpers/bacon', __FILE__)
require File.expand_path('../helpers/mock_pry', __FILE__)

class Module
  public :remove_const
  public :remove_method
end

# turn warnings off (esp for Pry::Hooks which will generate warnings
# in tests)
$VERBOSE = nil

Pad = OpenStruct.new
def Pad.clear
  @table = {}
end

# to help with tracking down bugs that cause an infinite loop in the test suite
if ENV["SET_TRACE_FUNC"]
  require 'set_trace' if Pry::Helpers::BaseHelpers.rbx?
  set_trace_func proc { |event, file, line, id, binding, classname|
     STDERR.printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
  }
end
