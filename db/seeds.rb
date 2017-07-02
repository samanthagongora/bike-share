require 'csv'
require 'pry'
require 'Date'
require 'active_support/core_ext/time'
require_relative '../app/models/city'
require_relative '../app/models/station_names'
require_relative '../app/models/bike_share_date'

City.destroy_all
StationName.destroy_all
BikeShareDate.destroy_all

city_text = File.read('./db/csv/city.csv')
city_csv = CSV.parse(city_text, :headers => true, header_converters: :symbol)
city_csv.each do |row|
  city = City.find_or_create_by!(name: row[:name])
end

station_names_text = File.read('./db/csv/station.csv')
station_names = CSV.parse(station_names_text, :headers => true, header_converters: :symbol)
station_names.each do |row|
  station_names = StationName.find_or_create_by!(name: row[:name])
end

station_dates_text = File.read('./db/csv/station_dates.csv')
station_dates_csv =  CSV.parse(station_dates_text, :headers => true, header_converters: :symbol)
station_dates_csv.each do |row|
  date = DateTime.strptime(row[:installation_date], '%m/%d/%Y')
  station_dates = BikeShareDate.find_or_create_by!(date: date)
end
# all_dates = station_dates_csv.map do |row|
#   row[:installation_date]
#   end
# dates = all_dates.uniq

# dates.each do |date|
#   station_dates = BikeShareDate.find_or_create_by!(date: date)
# end

# station_text = File.read('./db/csv/station.csv')
# station = CSV.parse(station_text, :headers => true, header_converters: :symbol)
# station.each do |row|
#   station = city.stations.create!(name: row[:name],
#                                   dock_count: row[:dock_count],
#                                   installation_date: format_date(row[:installation_date]))
#   StartStation.create(station_id: station.id)
#   EndStation.create(station_id: station.id)
