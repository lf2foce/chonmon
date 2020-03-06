class Location < ApplicationRecord
	belongs_to :user
	#belongs_to :post

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates_presence_of :address

end
