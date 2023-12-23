
module Backup

  class Mapper
    SOURCE_DIR_ROOT = "/Volumes/media/"
    LR_BACKUP = "/Volumes/CW/Lightroom/Backups"
    DEST_ROOT = "/Volumes/M"
    DEST_EXT = "[1-2][0-9]{,-{2,4}}"

    include Enumerable


    def initialize root=SOURCE_DIR_ROOT
      @root = root
      initialize_src_dest_map
    end

    def initialize_src_dest_map
      dest_dirs = DriveFinder.new(DEST_ROOT+DEST_EXT).dirs
      @src_dest_map = dest_dirs.map do |item|
        [find_src(item), item]
      end

      dest_dirs.each do |item|
        if is_current_year? item
          @src_dest_map << [catalog_backups, item]
        end

      end
    end

    def each(&block)
      @src_dest_map.each &block
    end

    def find_src(dest)
      year = '20' + two_digit_year(dest)
      source = "#{@root}#{year}"
    end

    def catalog_backups
      LR_BACKUP
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
