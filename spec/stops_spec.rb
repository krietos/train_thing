require 'spec_helper'

describe 'Stops' do

  describe('#initialize') do
    it('is initialized with a station_id, and a line_id') do
      test_stop = Stops.new({'station_id' => '1', 'line_id' => '1'})
      test_stop.should be_an_instance_of Stops
    end
  end

  describe('#save') do
    it('saves the instance to the database') do
      test_stop = Stops.new({'station_id' => '1', 'line_id' => '1'})
      new_test = test_stop.save
      new_test.should be_an_instance_of String
    end
  end

  describe('#all') do
    it('should list all the stops in the stops table') do
      test_stop = Stops.new({'station_id' => '1', 'line_id' => '1'})
      test_stop.save
      Stops.all.should eq [test_stop]
    end
  end

  describe('#==') do
    it('should be equal to another stop if it has the same line_id, station_id, and id') do
      test_stop1 = Stops.new({'station_id' => '1', 'line_id' => '1'})
      test_stop2 = Stops.new({'station_id' => '1', 'line_id' => '1'})
      test_stop1.should eq test_stop2
    end
  end

  describe('#delete') do
    it('removes a stop from the database') do
      test_stop = Stops.new({'station_id' => '1', 'line_id' => '1'})
      test_stop.save
      test_stop.delete
      Stops.all.should eq []
    end
  end
end
