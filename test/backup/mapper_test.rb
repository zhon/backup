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

  end
end
