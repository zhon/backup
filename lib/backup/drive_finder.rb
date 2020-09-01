
module Backup

  class DriveFinder
    BACK_UP_ROOT = "/Volumes/M"
    BACK_UP_EXT = "[1-2][0-9]"

    def initialize(destination=nil)
      @destination = destination || BACK_UP_ROOT+BACK_UP_EXT
    end

    def dirs
      dirs = Dir.glob @destination
      raise Error.new  "Error: Missing backup drive: #@destination" if dirs.empty?
      dirs
    end

  end

end
