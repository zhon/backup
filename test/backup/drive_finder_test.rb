require 'test_helper'

module Backup

  describe 'DriveFinder' do

      it "has default args that match /Volumes" do
        default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
        assert_equal "/Volumes/M[1-2][0-9]", default
      end


    describe 'with overridden system calls' do

      it "Dir.glob is called with default args" do
        default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
        mock(Dir).glob( default )

        DriveFinder.new.dirs
      end

      it "Dir.glob is called with default args when passed nil" do
        default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
        mock(Dir).glob( default )

        DriveFinder.new(nil).dirs
      end

      it "Dir.glob is called with specifited root args" do
        destination = "/backup_dir"
        mock(Dir).glob destination

        DriveFinder.new(destination).dirs
      end

    end

  end

end
