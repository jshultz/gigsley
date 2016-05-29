class ChangeGigSchedIdToGigIdInAvailability < ActiveRecord::Migration
  def change
    rename_column :availability, :gig_sched_id, :gig_id
  end
end
