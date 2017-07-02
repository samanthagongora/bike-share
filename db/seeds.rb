require 'csv'
require 'pry'
require 'Date'
require 'active_support/core_ext/time'
require './app/models/city'
require './app/models/station_name'
require './app/models/bike_share_date'
require './app/models/station'

City.destroy_all
StationName.destroy_all
BikeShareDate.destroy_all
Station.destroy_all

station_text = File.read('./db/csv/station.csv')
station_csv = CSV.parse(station_text, :headers => true, header_converters: :symbol)
station_csv.each do |row|
  station_name      = StationName.find_or_create_by!(name: row[:name])
  date              = DateTime.strptime(row[:installation_date], '%m/%d/%Y')
  installation_date = BikeShareDate.find_or_create_by!(bike_share_date: date)
  city              = City.find_or_create_by!(name: row[:city])
  Station.find_or_create_by!(station_id:           row[:id],
                             station_name_id:      station_name.id,
                             lat:                  row[:lat],
                             long:                 row[:long],
                             dock_count:           row[:dock_count],
                             city_id:              city.id,
                             installation_date_id: installation_date.id)
end
