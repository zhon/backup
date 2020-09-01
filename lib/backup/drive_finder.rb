
module Backup

  class DriveFinder
    BACK_UP_ROOT = "/Volumes/M"
    BACK_UP_EXT = "[1-2][0-9]"

    def initialize(destination=nil)
      @destination = destination || BACK_UP_ROOT+BACK_UP_EXT
    end

    def dirs
      Dir.glob @destination
    end

  end

end
