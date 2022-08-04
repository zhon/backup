require 'date'

module Backup

  class CommandBuilder
    @@command = %w{rsync -av --exclude '.DS_Store' --exclude '.Trashes' --exclude '.TemporaryItems' --exclude '.fsenventsd' }
    @@backup_dir = '/trash'

    def self.build_command source, destination, options
      commands = []
      options = options.dup
      if options[:delete]
        options[:delete] = nil
        commands <<  @@command + opts(destination, options) + [source, destination]
        options[:delete] = true
      end
      commands << @@command + opts(destination, options) + [source, destination]
      commands
    end

    def self.opts backup_disk, options
      opts = []
      if options["dry-run"]
        opts << "--dry-run"
      end
      if options[:delete]
        opts += %W{--delete --backup --backup-dir=#{backup_disk}#{@@backup_dir}}
      end
      opts
    end

  end

  class CommandsBuilder

    def self.commands_array_builder mapper, options
      commands = []
      mapper.each do |src, dest|
        commands.push CommandBuilder::build_command src, dest, options
      end
      commands
    end

    def initialize mapper, options={}
      @commands = CommandsBuilder::commands_array_builder mapper, options
    end

    def to_s
      @commands.map {|item| item.map {|item| item.join ' ' }.join ' && ' }.join("\n")
    end

    def to_procs
      @commands.map do |item|
        -> {
          item.map { |args| -> {system *args} }.map(&:call)
        }
      end
    end

  end

end
