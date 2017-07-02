class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :bike_share_date
  belongs_to :station_name
  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true
end
