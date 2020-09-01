require 'test_helper'

module Backup

  describe 'DriveFinder' do

    it "has default args that match /Volumes" do
      default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
      assert_equal "/Volumes/M[1-2][0-9]", default
    end

    it "raises exception when no destination locations are found" do
      finder = DriveFinder.new '/not_a_dir'
      stub(Dir).glob { [] }

      err = assert_raises(Error) {
        finder.dirs
      }
      assert_match "Missing backup drive: " , err.message
      assert_match /not_a_dir/, err.message
    end

    it "dirs returns array of dirs" do
      result = ['/not_really_a_dir']
      finder = DriveFinder.new
      stub(Dir).glob { result }
      assert_equal result, finder.dirs
    end

    it "removes trailing slash from destination" do
      finder = DriveFinder.new '/*/'
      dirs = finder.dirs
      refute dirs.empty?
      dirs.each do |item|
        refute_match /\/$/, item
      end
    end


    describe 'with overridden system calls' do

      it "Dir.glob is called with default args" do
        default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
        mock(Dir).glob( default ) {["dir"]}

        DriveFinder.new.dirs
      end

      it "Dir.glob is called with default args when passed nil" do
        default = DriveFinder::BACK_UP_ROOT + DriveFinder::BACK_UP_EXT
        mock(Dir).glob( default ) {["dir"]}

        DriveFinder.new(nil).dirs
      end

      it "Dir.glob is called with specifited root args" do
        destination = "/backup_dir"
        mock(Dir).glob(destination) {["dir"]}

        DriveFinder.new(destination).dirs
      end

    end

  end

end
