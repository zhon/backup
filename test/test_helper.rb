$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "backup"

require "minitest/autorun"
require "rr"

require 'rantly'
require 'rantly/minitest_extensions'
