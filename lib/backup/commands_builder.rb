
module Backup

  class CommandsBuilder

    @@command = %w{rsync -av --exclude .DS_STORE }

    def initialize backup_disks, options={}
      @backup_disks = backup_disks
      @options = options
    end

    def commands
      commands = []
      @backup_disks.each do |item|
        source = Backup::Mapper.new.find_src(item)
        commands.push(@@command + opts(item) + [source, item])
      end
      commands
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
