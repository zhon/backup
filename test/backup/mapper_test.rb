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
      source = '/Volumes/Media/2019'
      assert_equal source, Mapper.new.find_src(destination)
    end

    it "maps destination to source" do
      destination = '/Volumes/M20'
      source = '/Volumes/Media/2020'
      assert_equal source, Mapper.new.find_src(destination)
    end

    it "maps destination to source" do
      destination = '/Volumes/M20-3'
      source = '/Volumes/Media/2020'
      assert_equal source, Mapper.new.find_src(destination)
    end

    describe 'find_catalog' do

      it "finds catalog on source" do
        stub(Dir).glob { ['somepath/catalog.lrcat'] }
        assert_equal 'somepath/catalog.lrcat', Mapper.new.find_catalog
      end

      it "Dir.glob is called with default location" do
        mock(Dir).glob( '/Volumes/Media/*.lrcat') {["dir"]}

        Mapper.new.find_catalog
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
