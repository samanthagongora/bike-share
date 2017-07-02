class BikeShareDate < ActiveRecord::Base
  has_many :stations, :foreign_key => 'installation_date_id'


end
