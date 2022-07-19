require 'test_helper'

module Backup

  describe Mapper do

    describe "maps destination to source" do

      it "without -" do
        property_of {
           sized(2) {string(:digit)}
        }.check(3) { |label|
          destination = "/Volumes/M#{label}"
          source = "/Volumes/media/20#{label}"
          assert_equal source, Mapper.new.find_src(destination)
        }
      end

      it "with -" do
        property_of {
           sized(2) {string(:digit) + '-' + sized(1) {string(:digit)}}
        }.check(3) { |label|
          destination = "/Volumes/M#{label}"
          source = "/Volumes/media/20#{label.split('-')[0]}"
          assert_equal source, Mapper.new.find_src(destination)
        }
      end

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
