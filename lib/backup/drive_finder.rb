
module Backup

  class DriveFinder

    def initialize(destination)
      @destination = destination
      remove_trailing_slash
    end

    def dirs
      dirs = Dir.glob @destination
      raise Error.new  "Error: Missing backup drive: #@destination" if dirs.empty?
      dirs
    end

    def remove_trailing_slash
      @destination.chomp!('/')
    end

  end

end
