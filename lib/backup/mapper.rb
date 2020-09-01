
module Backup

  class Mapper
    SOURCE_DIR_ROOT = "/Volumes/Media/"

    def initialize root=SOURCE_DIR_ROOT
      @root = root
    end

    def find_src(dest)
      year = '20' + two_digit_year(dest)
      source = "#{@root}#{year}"
    end

    def two_digit_year dest
      dest =~ /.*M(\d\d)/
      $1
    end

  end

end
