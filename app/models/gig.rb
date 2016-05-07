class Gig < ActiveRecord::Base
  self.table_name = "gig"
  belongs_to :profile
end
