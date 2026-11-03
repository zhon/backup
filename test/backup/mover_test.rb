require 'test_helper'

module Backup

  describe Mover do

    require 'tmpdir'
    require 'fileutils'

    describe "move_destination" do

      it "doesn't move when src is only a date" do
        dir = Dir.mktmpdir("backup-mover-tests-", "/tmp")
        at_exit { FileUtils.remove_entry(dir) }
        dest = "#{dir}/backup/2022-07-02"
        src = "#{dir}/src/2022-07-02"
        FileUtils.mkdir_p(dest)
        FileUtils.mkdir_p(src)

        Mover::move_destination(src, dest)

        assert Dir.exist? "#{dir}/backup/2022-07-02"
      end

      it "renames dest to src's descriptive name" do
        dir = Dir.mktmpdir("backup-mover-tests-", "/tmp")
        at_exit { FileUtils.remove_entry(dir) }

        dest = "#{dir}/backup/2022-07-02"
        src = "#{dir}/src/2022-07-02 More After"
        FileUtils.mkdir_p(dest)
        FileUtils.mkdir_p(src)

        Mover::move_destination(src, dest)

        assert Dir.exist? "#{dir}/backup/2022-07-02 More After"
      end

    end

  end

end