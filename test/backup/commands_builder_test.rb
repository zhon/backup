require 'test_helper'

module Backup

  describe CommandsBuilder do

    describe 'commands_array_builder' do

      it "with empty backup disks return no commands" do
        mapper = []
        commands = CommandsBuilder::commands_array_builder(mapper, {})
        assert_equal [], commands
      end

      it "options will show in command" do
        mapper = [ ["source", ENV["TMPDIR"] + "M20"]]
        options = {
          delete: true,
          'dry-run' => true
        }

        commands = CommandsBuilder::commands_array_builder(mapper, options)

        command = commands[0].flatten
        assert_includes command, '--delete'
        assert_includes command, '--dry-run'
        assert_includes command, "--backup-dir=#{mapper[0][1]}/trash"
      end

      it "--delete will have a non delete followed by a delete command" do
        mapper = [ "M20", ENV["TMPDIR"] + "M20" ]
        options = {
          delete: true,
        }

        commands = CommandsBuilder::commands_array_builder(mapper, options)

        command = commands[0][0]
        refute_includes command, '--delete'
        command = commands[0][1].flatten
        assert_includes command, '--delete'
      end


    end

    describe "to_s" do

      it "with --debug will produce two commands that run sequentially``" do
        mapper = [ "M19", ENV["TMPDIR"] + "M19" ]
        options = {
          delete: true,
        }.freeze

        cb = CommandsBuilder.new mapper, options
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
