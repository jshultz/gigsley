class Profile < ActiveRecord::Base
  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode #, if: ->(obj){ obj.full_address.present? and obj.full_address.changed? }

  acts_as_messageable
  acts_as_ordered_taggable # Alias for acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :skills, :interests

  include PgSearch

  belongs_to :user
  has_one :job
  has_one :bio
  has_many :gigs
  has_one :experience
  has_one :schedule
  has_many :galleries

  pg_search_scope :profile_search, :against => [:first_name, :last_name]

end
