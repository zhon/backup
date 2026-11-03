require 'yaml'

module Backup
  module Config

    DEFAULTS = {
      'source_dir_root' => '/Volumes/media/',
      'lr_backup'       => '/Volumes/Current/Lightroom/Backups',
      'dest_root'       => '/Volumes/M',
    }.freeze

    @cache = nil

    def self.reset!
      @cache = nil
    end

    def self.data
      @cache ||= load
    end

    def self.load
      path = ENV['BACKUP_CONFIG']
      path = File.expand_path('~/.backup.yml') if path.nil? || path.empty?
      user = File.exist?(path) ? (YAML.load_file(path) || {}) : {}
      DEFAULTS.merge(user)
    rescue StandardError
      DEFAULTS.dup
    end

    def self.source_dir_root
      data['source_dir_root']
    end

    def self.lr_backup
      data['lr_backup']
    end

    def self.dest_root
      data['dest_root']
    end

  end
end