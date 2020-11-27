require 'date'

module Backup

  class CommandsBuilder

    @@command = %w{rsync -av --exclude .DS_STORE }

    def initialize backup_disks, options={}
      @backup_disks = backup_disks
      @options = options
    end

    def to_s
      @commands ||= commands
      @commands.map {|item| item.map {|item| item.join ' ' }.join ' && ' }.join("\n")
    end

    def to_procs
      @commands ||= commands
      @commands.map do |item|
        -> {
          item.map { |args| p args; -> {system *args} }.map(&:call)
        }
      end
    end

    def commands
      return @commands if @commands
      mapper = Mapper.new
      @commands = []
      @backup_disks.each do |item|
        source = mapper.find_src(item)
        @commands.push build_command source, item
        @commands.push build_command mapper.find_catalog, item if mapper.is_current_year?(item)
      end
      @commands
    end

    def build_command(source, destination, options = @options.dup)
      commands = []
      if options[:delete]
        options[:delete] = nil
        commands <<  @@command + opts(destination, options) + [source, destination]
        options[:delete] = true
      end
      commands << @@command + opts(destination, options) + [source, destination]
      commands
    end

    def opts(backup_disk, options = @options)
      opts = []
      if options["dry-run"]
        opts << "--dry-run"
      end
      if options[:delete]
        opts += %W{--delete --backup --backup-dir=#{backup_disk}/trash}
      end
      opts
    end

  end

end
