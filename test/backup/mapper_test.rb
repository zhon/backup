require 'test_helper'

module Backup

  describe Mapper do

    def stub_df_dirs
      any_instance_of(DriveFinder) do |klass|
        stub(klass).dirs {
          [
            '/not a drive/M21',
            '/not a drive/M22',
            '/not a drive/M23-3',
            '/not a drive/M23-4',
          ]
        }
      end
    end

    describe "Enumerator" do

      it "will return an Emumerator" do
        stub_df_dirs

        mapper = Mapper.new
        assert_kind_of Enumerator, mapper.each
      end

      it "first will return an pair: src, dest" do
        stub_df_dirs

        mapper = Mapper.new

        assert_kind_of Array, mapper.first
        assert_equal ["/Volumes/media/2021", "/not a drive/M21"], mapper.first
      end
    end

    describe "find_src maps destination to source" do

      it "without -" do
        stub_df_dirs
        property_of {
           sized(2) {string(:digit)}
        }.check(3) { |label|
          destination = "/Volumes/M#{label}"

          any_instance_of(DriveFinder) do |klass|
            stub(klass).dirs {
              [ destination ]
            }
          end

          source = "/Volumes/media/20#{label}"
          assert_equal [source, destination], Mapper.new.first
        }
      end

      it "with -" do
        stub_df_dirs
        property_of {
           sized(2) {string(:digit) + '-' + sized(1) {string(:digit)}}
        }.check(3) { |label|
          destination = "/Volumes/M#{label}"

          any_instance_of(DriveFinder) do |klass|
            stub(klass).dirs {
              [ destination ]
            }
          end

          source = "/Volumes/media/20#{label.split('-')[0]}"
          assert_equal source, Mapper.new.first.first
        }
      end

    end

    describe 'catalog_backups' do

      it "finds catalog backups location" do
        any_instance_of(DriveFinder) do |klass|
          stub(klass).dirs {
            [ '/not a dir/M22' ]
          }
        end

        Timecop.freeze(Time.new(2022, 7, 1)) do
          e = Mapper.new.each
          e.next
          assert_equal '/Volumes/CW/Lightroom/Backups', e.next.first
        end
      end

    end

    describe 'is_current_year?' do

      it "returns true for current year" do
        stub_df_dirs
        Timecop.freeze(Time.new(2019, 1, 1)) do
          destination = '/Volumes/M19-3'
          assert_equal true, Mapper.new.is_current_year?(destination)
        end
      end

    end

  end
end
