class Lines

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def ==(another_line)
    self.name == another_line.name && self.id == another_line.id
  end

  def save
    results = DB.exec("INSERT INTO lines (name) VALUES ('#{@name.downcase}') RETURNING id;")
    @id = results.first['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM lines;")
    lines = []
    results.each do |result|
      lines << Lines.new(result)
    end
    lines
  end

  def delete
    DB.exec("DELETE FROM lines WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE line_id = #{@id};")
  end

  def stops
    results = DB.exec("SELECT * FROM stops WHERE line_id = #{@id};")
    stops = []
    Stations.all.each do |station|
      results.each do |stop|
        if station.id.to_i == stop['station_id'].to_i
          stops << station
        end
      end
    end
    stops
  end

end
