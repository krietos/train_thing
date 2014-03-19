require 'spec_helper'

describe('Lines') do
  describe('initialize') do
    it('should create a new instance of line') do
      test_line = Lines.new({'name' => 'red'})
      test_line.should(be_an_instance_of(Lines))
    end
  end
  describe('==') do
    it('should be the same line if the name and id are the same') do
      test_line1 = Lines.new({'name' => 'red', 'id' => '1'})
      test_line2 = Lines.new({'name' => 'red', 'id' => '1'})
      test_line1.should(eq(test_line2))
    end
  end
  describe('save') do
    it('should save the instance to the database') do
      test_line = Lines.new({'name' => 'red'})
      test_line.save
      Lines.all.should(eq([test_line]))
    end
  end
  describe('.all') do
    it('should return an array of all the lines') do
      test_line = Lines.new({'name' => 'red'})
      test_line.save
      Lines.all.should(eq([test_line]))
    end
  end
  describe('delete') do
    it('should delete a line from the database') do
      test_line = Lines.new({'name' => "line a"})
      test_line.save
      test_line.delete
      Lines.all.should eq []
    end
  end
  describe('#stops') do
    it('returns all the stations associated with a given line') do
      test_station = Stations.new({'name' => "station a"})
      station_id = test_station.save
      test_line = Lines.new({'name' => 'red'})
      line_id = test_line.save
      test_stop = Stops.new({'station_id' => station_id, 'line_id' => line_id})
      test_stop.save
      test_line.stops.should eq [test_station]
    end
  end


end
