
module Backup

  class Mapper
    SOURCE_DIR_ROOT = "/Volumes/media/"

    def initialize root=SOURCE_DIR_ROOT
      @root = root
    end

    def find_src(dest)
      year = '20' + two_digit_year(dest)
      source = "#{@root}#{year}"
    end

    def find_catalog_backups
      File.expand_path("~/SynologyDrive/Lightroom/Backups")
    end

    def two_digit_year dest
      dest =~ /.*M(\d\d)/
      $1
    end

    def is_current_year?(backup_disk)
      two_digit_year(backup_disk) == Date.today.year.to_s[-2..-1]
    end

  end

end
