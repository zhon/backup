require 'test_helper'

module Backup

  describe DriveFinder do

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
      finder = DriveFinder.new 'empty base dir'
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

      it "Dir.glob is called with specifited root args" do
        destination = "/backup_dir"
        mock(Dir).glob(destination) {["dir"]}

        DriveFinder.new(destination).dirs
      end

    end

  end

end
