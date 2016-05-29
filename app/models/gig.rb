class Gig < ActiveRecord::Base
  self.table_name = "gig"
  belongs_to :profile

  has_many :availability

  validates :jobName, presence: true, on: [:create,:update]
  validates :description, presence: true, on: [:create,:update]
  validates :endDate, presence: true, on: [:create,:update]

end
