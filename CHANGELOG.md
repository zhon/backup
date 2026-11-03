# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-11-02

### Added
- Configurable paths via ~/.backup.yml (source_dir_root, lr_backup, dest_root)
- Mover for renaming destination folders to match descriptive source names
- GitHub Actions CI on Ruby 4

### Changed
- Dropped custom threadpool gem; use stdlib Thread + Queue
- Removed empty cw2nas command
- Modernized for Ruby 3.x/4.x (Dir.exist?, FileUtils array handling, Minitest)
- Fixed backup-drive glob pattern and nil-year guard
- Gem packaging: bin/backup executable, changelog URI, required_ruby_version

### Fixed
- DriveFinder trailing-slash handling
- Mapper date/year parsing

## [0.1.1] - 2019-07-22

### Added
- Backups happen both synchronously and asynchronously
- ```--delete``` run a non delete before running the delete to avoid non deleted files showing up in the backup directory
- Backup disks can be named '-2' or '-3' (ex., 'M20-3')
- Back up the catalog if the backup disk is the current year

### Changed
- Requires ```bundle exec``` to run because of unrelease verstion of 'threadpool'

## [0.1.0] - 2019-07-22