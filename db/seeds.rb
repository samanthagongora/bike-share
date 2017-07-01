require 'csv'
require_relative '../app/models/city'
require_relative '../app/models/station_names'

City.destroy_all
StationName.destroy_all

city_text = File.read('./db/csv/city.csv')
city = CSV.parse(city_text, :headers => true, header_converters: :symbol)
city.each do |row|
  city = City.find_or_create_by!(name: row[:name])
end

station_names_text = File.read('./db/csv/station.csv')
station_names = CSV.parse(station_names_text, :headers => true, header_converters: :symbol)
station_names.each do |row|
  station_names = StationName.find_or_create_by!(name: row[:name])
end

# station_text = File.read('./db/csv/station.csv')
# station = CSV.parse(station_text, :headers => true, header_converters: :symbol)
# station.each do |row|
#   station = city.stations.create!(name: row[:name],
#                                   dock_count: row[:dock_count],
#                                   installation_date: format_date(row[:installation_date]))
#   StartStation.create(station_id: station.id)
#   EndStation.create(station_id: station.id)
