require 'test_helper'

module Backup

  describe CommandsBuilder do

    describe 'commands_array_builder' do

      it "with empty backup disks return no commands" do
        backup_disks = []
        commands = CommandsBuilder::commands_array_builder(backup_disks, {})
        assert_equal [], commands
      end

      it "options will show in command" do
        backup_disks = [ ENV["TMPDIR"] + "M20" ]
        options = {
          delete: true,
          'dry-run' => true
        }

        commands = CommandsBuilder::commands_array_builder(backup_disks, options)

        command = commands[0].flatten
        assert_includes command, '--delete'
        assert_includes command, '--dry-run'
        assert_includes command, "--backup-dir=#{backup_disks[0]}/trash"
      end

      it "--delete will have a non delete followed by a delete command" do
        backup_disks = [ "M20" ]
        options = {
          delete: true,
        }

        commands = CommandsBuilder::commands_array_builder(backup_disks, options)

        command = commands[0][0]
        refute_includes command, '--delete'
        command = commands[0][1].flatten
        assert_includes command, '--delete'
      end

      it "with mutiple drives it will create mutiple commands" do
        backup_disks = [
          ENV["TMPDIR"] + "M20",
          ENV["TMPDIR"] + "M21"
        ]
        options = {}

        any_instance_of(Mapper) do |m|
          stub(m).is_current_year? { false }
        end

        commands = CommandsBuilder::commands_array_builder(backup_disks, options)
        assert_equal 2, commands.size
        assert_equal "M20", commands[0][0][-1][-3..-1]
        assert_equal "M21", commands[1][0][-1][-3..-1]
      end

      it "current year will backup catalog" do
        backup_disks = [
          ENV["TMPDIR"] + "M19",
        ]
        options = {}

        Timecop.freeze(Time.new(2019, 1, 1)) do
          commands = CommandsBuilder::commands_array_builder(backup_disks, options)
          assert_equal 2, commands.size
        end
      end


    end

    describe "to_s" do

      it "with --debug will produce two commands that run sequentially``" do
        backup_disks = [ ENV["TMPDIR"] + "M19" ]
        options = {
          delete: true,
        }.freeze

        cb = CommandsBuilder.new backup_disks, options
        assert_match /rsync.* && rsync.*--delete/, cb.to_s
      end

    end

    describe "to_procs" do

      it "to_procs will produce array of arrays of procs" do
        commands = [[
          ["rsync", "-av", "--exclude", ".DS_STORE", "/Volumes/Media/2020", "/some tmp location/M20"]
        ],
        [
          ["rsync", "-av", "--exclude", ".DS_STORE", "/Volumes/Media/2021", "/some tmp location/M21"]
        ]]

        stub(CommandsBuilder).commands_array_builder { commands }

        result = CommandsBuilder.new([]).to_procs
        assert_kind_of Proc, result[0]
      end

    end

  end
end
