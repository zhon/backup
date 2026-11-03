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

      it "skips when target already exists" do
        dir = Dir.mktmpdir("backup-mover-tests-", "/tmp")
        at_exit { FileUtils.remove_entry(dir) }

        dest = "#{dir}/backup/2022-07-02"
        src = "#{dir}/src/2022-07-02 More After"
        FileUtils.mkdir_p(dest)
        FileUtils.mkdir_p(src)
        FileUtils.mkdir_p("#{dir}/backup/2022-07-02 More After")

        result = Mover.move_destination(src, dest)

        assert_nil result
        assert Dir.exist? dest
        assert Dir.exist? "#{dir}/backup/2022-07-02 More After"
      end

      it "does nothing when destination is missing" do
        dir = Dir.mktmpdir("backup-mover-tests-", "/tmp")
        at_exit { FileUtils.remove_entry(dir) }

        dest = "#{dir}/backup/does-not-exist"
        src = "#{dir}/src/2022-07-02 More After"
        FileUtils.mkdir_p(src)

        result = Mover.move_destination(src, dest)

        assert_nil result
        refute Dir.exist? dest
      end

    end

  end

end