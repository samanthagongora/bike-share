require 'csv'
require 'pry'
require 'Date'
require 'active_support/core_ext/time'
require_relative '../app/models/city'
require_relative '../app/models/station_name'
require_relative '../app/models/bike_share_date'

City.destroy_all
StationName.destroy_all
BikeShareDate.destroy_all

city_text = File.read('./db/csv/city.csv')
city_csv = CSV.parse(city_text, :headers => true, header_converters: :symbol)
city_csv.each do |row|
  city = City.find_or_create_by!(name: row[:name])
end

station_text = File.read('./db/csv/station.csv')
station_names_csv = CSV.parse(station_text, :headers => true, header_converters: :symbol)
station_names_csv.each do |row|
  station_names = StationName.find_or_create_by!(name: row[:name])
end

station_dates_csv =  CSV.parse(station_text, :headers => true, header_converters: :symbol)
station_dates_csv.each do |row|
  date = DateTime.strptime(row[:installation_date], '%m/%d/%Y')
  station_dates = BikeShareDate.find_or_create_by!(date: date)
end
