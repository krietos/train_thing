class Stops

  attr_reader :station_id, :line_id, :id, :time

  def initialize(attributes)
    @station_id = attributes['station_id']
    @line_id = attributes['line_id']
    @id = attributes['id']
    @time = attributes['time']
  end

  def save
    results = DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{@station_id}, #{@line_id}) RETURNING id;")
    @id = results.first['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM stops;")
    stops = []
    results.each do |result|
      stops << Stops.new(result)
    end
    stops
  end

  def ==(another_stop)
    self.station_id == another_stop.station_id && self.line_id == another_stop.line_id && self.id == another_stop.id
  end

  def delete
    DB.exec("DELETE FROM stops WHERE station_id = #{@station_id} AND line_id = #{@line_id};")
  end

end
