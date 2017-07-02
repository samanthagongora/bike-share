require 'csv'
require 'pry'
require 'Date'
require 'active_support/core_ext/time'
require './app/models/city'
require './app/models/station_name'
require './app/models/bike_share_date'

City.destroy_all
StationName.destroy_all
BikeShareDate.destroy_all

station_text = File.read('./db/csv/station.csv')
station_csv = CSV.parse(station_text, :headers => true, header_converters: :symbol)
station_csv.each do |row|
  station_names = StationName.find_or_create_by!(name: row[:name])
  date = DateTime.strptime(row[:installation_date], '%m/%d/%Y')
  station_dates = BikeShareDate.find_or_create_by!(date: date)
  city = City.find_or_create_by!(name: row[:city])
end
