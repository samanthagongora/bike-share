class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :bike_share_date
  belongs_to :station_name
  validates :station_name_id, presence: true
  validates :dock_count, presence: true
  validates :city_id, presence: true
  validates :installation_date_id, presence: true
end
