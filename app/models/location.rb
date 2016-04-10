class Location < ActiveRecord::Base
  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode #, if: ->(obj){ obj.full_address.present? and obj.full_address.changed? }
end