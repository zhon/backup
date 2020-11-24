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

      it "with mutiple drives it will create mutiple commands" do
        backup_disks = [
          ENV["TMPDIR"] + "M20",
          ENV["TMPDIR"] + "M21"
        ]

        any_instance_of(Mapper) do |m|
          stub(m).is_current_year? { false }
        end

        cb = CommandsBuilder.new backup_disks
        commands = cb.commands
        assert_equal 2, commands.size
        assert_equal "M20", commands[0][-1][-3..-1]
        assert_equal "M21", commands[1][-1][-3..-1]
      end

      it "current year will backup catalog" do
        backup_disks = [
          ENV["TMPDIR"] + "M19",
        ]

        Timecop.freeze(Time.new(2019, 1, 1)) do
          cb = CommandsBuilder.new backup_disks
          commands = cb.commands
          assert_equal 2, commands.size
        end
      end

    end
  end
end
