require 'csv'
require 'pry'
require 'Date'
require 'active_support/core_ext/time'
require './app/models/city'
require './app/models/station_name'
require './app/models/bike_share_date'
require './app/models/station'
require './app/models/subscription_type'
require './app/models/zip_code'
require './app/models/trip'

City.destroy_all
StationName.destroy_all
BikeShareDate.destroy_all
Station.destroy_all
Trip.destroy_all
SubscriptionType.destroy_all
ZipCode.destroy_all


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

trip_text = File.read('./db/csv/trip_test.csv')
trip_csv = CSV.parse(trip_text, :headers => true, header_converters: :symbol)
trip_csv.each do |row|
  prelim_start_date = DateTime.strptime(row[:start_date], '%m/%d/%Y %H:%M')
  start_date_entry  = BikeShareDate.find_or_create_by!(bike_share_date: prelim_start_date)
  ss_name_entry     = StationName.find_by(name: row[:start_station_name])
  ss_id_entry       = Station.find_by(station_id: row[:start_station_id])
  prelim_end_date   = DateTime.strptime(row[:end_date], '%m/%d/%Y %H:%M')
  end_date_entry    = BikeShareDate.find_or_create_by!(bike_share_date: prelim_end_date)
  es_name_entry     = StationName.find_by(name: row[:end_station_name])
  es_id_entry       = Station.find_by(station_id: row[:end_station_id])
  e_sub_type        = SubscriptionType.find_or_create_by!(name: row[:subscription_type])
  entry_zip         = ZipCode.find_or_create_by!(zip_code: row[:zip_code])
  Trip.find_or_create_by!(trip_id:               row[:id],
                          duration:              row[:duration],
                          start_date_id:         start_date_entry.id,
                          start_station_name_id: ss_name_entry.id,
                          start_station_id:      ss_id_entry.station_id,
                          end_date_id:           end_date_entry.id,
                          end_station_name_id:   es_name_entry.id,
                          end_station_id:        es_id_entry.station_id,
                          bike_id:               row[:bike_id],
                          subscription_type_id:  e_sub_type.id,
                          zip_code_id:           entry_zip.id)
end
