require 'test_helper'

module Backup

  describe CommandsBuilder do

    describe 'commands' do

      it "with empty backup disks return no commands" do
        backup_disks = []

        cb = CommandsBuilder.new backup_disks
        commands = cb.commands
        assert_equal [], commands
      end

      it "options will show in command" do
        backup_disks = [ ENV["TMPDIR"] + "M20" ]
        options = {
          delete: true,
          'dry-run' => true
        }

        cb = CommandsBuilder.new backup_disks, options

        command = cb.commands[0]
        assert_includes command, '--delete'
        assert_includes command, '--dry-run'
        assert_includes command, "--backup-dir=#{backup_disks[0]}/trash"
      end

    end
  end
end
