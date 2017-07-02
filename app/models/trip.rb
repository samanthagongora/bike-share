class Trip < ActiveRecord::Base
  belongs_to :station
  belongs_to :station_name
  belongs_to :subscription_type
  belongs_to :zip_code
  belongs_to :bike_share_date
end
