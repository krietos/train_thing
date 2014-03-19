require 'spec_helper'

describe('Stations') do
  describe('#initialize') do
    it('should create a new instance of station') do
      test_station = Stations.new({'name' => "station a"})
      test_station.should(be_an_instance_of(Stations))
    end
  end

  describe('#save') do
    it('should save the instance') do
      test_station = Stations.new({'name' => "station a"})
      test_station.save
      Stations.all.should eq [test_station]
    end
  end

  describe('#==') do
    it('should equal the same station if the name and id are the same') do
      test_station1 = Stations.new({'name' => "station a"})
      test_station2 = Stations.new({'name' => "station a"})
      test_station1.should(eq(test_station2))
    end
  end

  describe('.all') do
    it('returns an array of all the saved station objects') do
      test_station = Stations.new({'name' => "station a"})
      test_station.save
      Stations.all.should eq [test_station]
    end
  end

  describe('#delete') do
    it('should delete a station from the database') do
      test_station = Stations.new({'name' => "station a"})
      test_station.save
      test_station.delete
      Stations.all.should eq []
    end
  end

  describe('#stops') do
    it('returns all the lines associated with a given station') do
      test_station = Stations.new({'name' => "station a"})
      station_id = test_station.save
      test_line = Lines.new({'name' => 'red'})
      line_id = test_line.save
      test_stop = Stops.new({'station_id' => station_id, 'line_id' => line_id})
      test_stop.save
      test_station.stops.should eq [test_line]
    end
  end
end













