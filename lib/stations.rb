class Stations

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def save
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name.downcase}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_station)
    self.name == another_station.name && self.id == another_station.id
  end

  def self.all
    results = DB.exec("SELECT * FROM stations;")
    stations = []
    results.each do |result|
      stations << Stations.new(result)
    end
    stations
  end

  def delete
    DB.exec("DELETE FROM stations WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE station_id = #{@id};")
  end

  def stops
    results = DB.exec("SELECT * FROM stops WHERE station_id = #{@id};")
    stops = []
    results.each do |stop|
      Lines.all.each do |line|
        if stop['line_id'].to_i == line.id.to_i
          stops << line
        end
      end
    end
    stops
  end

end
