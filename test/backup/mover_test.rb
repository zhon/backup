require 'test_helper'

module Backup

  describe Mover do

    def stub_df_dirs
      any_instance_of(DriveFinder) do |klass|
        stub(klass).dirs {
          [
            '/not a drive/M21',
            '/not a drive/M22',
            '/not a drive/M23-3',
          ]
        }
      end
    end

    describe "move_destination" do

      describe "doesn't move" do

        it "when src is only a date" do
            

        end


      end
      require 'tmpdir'
      require 'fileutils'


      it "" do
        skip "Mover implementation pending design review"

        dir = Dir.mktmpdir("backup-mapper-tests-", "/tmp")
        at_exit { FileUtils.remove_entry(dir) }


        dest = FileUtils.mkdir_p("#{dir}/backup/2022-07-02")
        src = FileUtils.mkdir_p("#{dir}/src/2022-07-02 More After")


        Mover::move_destination(src, dest)

        assert Dir.exist? "#{dir}/backup/2022-07-02 More After"
      end
    end
  end

end
