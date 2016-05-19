class Bio < ActiveRecord::Base
  belongs_to :profile

  validates :title, presence: true, on: [:create,:update]
  validates :experience, presence: true, on: [:create,:update]
  validates :minHour, presence: true, on: [:create,:update]
  validates :maxHour, presence: true, on: [:create,:update]
  validates :travel, presence: true, on: [:create,:update]

end
