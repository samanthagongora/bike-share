class Station < ActiveRecord::Base
  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true

  def self.sql(query)
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.total_station_count
    Station.all.count
    #sql("SELECT COUNT(id) FROM stations").first["count"].to_i
  end

  def self.average_bikes_per_station
    sql("SELECT AVG(dock_count)FROM stations").first["avg"].to_i
  end

  def self.most_bikes_avaiable
    sql("SELECT name FROM stations ORDER BY dock_count ASC").first["name"]
  end

  def self.stations_with_most_bikes
    sql("SELECT name FROM stations ORDER BY dock_count ASC LIMIT 5").map {|x| "#{x["name"]}"}
  end

  def self.fewest_bikes_avaiable
    sql("SELECT name FROM stations ORDER BY dock_count DESC").first["name"]
  end

  def self.stations_with_fewest_bikes
    sql("SELECT name FROM stations ORDER BY dock_count DESC LIMIT 5").map {|x| "#{x["name"]}"}
  end

  def self.most_recent_station
    sql("SELECT name FROM stations ORDER BY installation_date ASC").first["name"]
  end

  def self.oldest_station
    sql("SELECT name FROM stations ORDER BY installation_date DESC").first["name"]
  end
end
