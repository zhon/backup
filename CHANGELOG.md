# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

rsync -av --exclude='.DS_Store' /Volumes/CW zhon@photostore::NetBackup/

rsync -av --exclude-from=/Users/zhon/.backup_excludes -e 'ssh' /Volumes/CW zhon@photostore::NetBackup/

exclude from a file


## [0.1.1] - 2019-07-22

### Added
- Backups happen both synchronously and asynchronously
- ```--delete``` run a non delete before running the delete to avoid non deleted files showing up in the backup directory
- Backup disks can be named '-2' or '-3' (ex., 'M20-3')
- Back up the catalog if the backup disk is the current year

### Changed
- Requires ```bundle exec``` to run because of unrelease verstion of 'threadpool'

## [0.1.0] - 2019-07-22

