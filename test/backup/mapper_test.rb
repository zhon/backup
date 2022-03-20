require 'test_helper'

module Backup

  describe Mapper do

    it 'sample rantly' do
      skip
      property_of {
        range 1, 10
      }.check {|tc|
        count = 0
        tp = ThreadQueue.new(tc)
        tc.times do
          tp.add -> { count += 1  }
        end
        tp.join
        count.must_equal tc
      }
    end

    it "maps destination to source" do
      destination = '/Volumes/M19'
      source = '/Volumes/media/2019'
      assert_equal source, Mapper.new.find_src(destination)
    end

    it "maps destination to source" do
      destination = '/Volumes/M20'
      source = '/Volumes/media/2020'
      assert_equal source, Mapper.new.find_src(destination)
    end

    it "maps destination to source" do
      destination = '/Volumes/M20-3'
      source = '/Volumes/media/2020'
      assert_equal source, Mapper.new.find_src(destination)
    end

    describe 'find_catalog_backups' do

      it "finds catalog backups location" do
        stub(File).expand_path { 'Backups' }
        assert_equal 'Backups', Mapper.new.find_catalog_backups
      end

      it "Dir.glob is called with default location" do
        mock(File).expand_path( '~/SynologyDrive/Lightroom/Backups') {}

        Mapper.new.find_catalog_backups
      end

    end

    describe 'is_current_year?' do

      it "returns true for current year" do
        Timecop.freeze(Time.new(2019, 1, 1)) do
          destination = '/Volumes/M19-3'
          assert_equal true, Mapper.new.is_current_year?(destination)
        end
      end

    end

  end
end
