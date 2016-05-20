class Availability < ActiveRecord::Base
  belongs_to :gig_sched, polymorphic: true
end