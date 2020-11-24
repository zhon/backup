require 'date'

module Backup

  class CommandsBuilder

    @@command = %w{rsync -av --exclude .DS_STORE }

    def initialize backup_disks, options={}
      @backup_disks = backup_disks
      @options = options
    end

    def commands
      mapper = Mapper.new
      commands = []
      @backup_disks.each do |item|
        source = mapper.find_src(item)
        commands.push build_command source, item
        commands.push build_command mapper.find_catalog, item if mapper.is_current_year?(item)
      end
      commands
    end

    def build_command(source, destination, is_catalog=false)
      @@command + opts(destination) + [source, destination]
    end

    def opts(backup_disk)
      opts = []
      if @options["dry-run"]
        opts << "--dry-run"
      end
      if @options[:delete]
        opts += %W{--delete --backup --backup-dir=#{backup_disk}/trash}
      end
      opts
    end

  end

end
