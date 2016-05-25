class ChangeAvailabilityTable < ActiveRecord::Migration
  def change
    add_column :availability, :earlyMorning, :boolean
    add_column :availability, :lateMorning, :boolean
    add_column :availability, :earlyAfternoon, :boolean
    add_column :availability, :lateAfternoon, :boolean
    add_column :availability, :earlyEvening, :boolean
    add_column :availability, :overnight, :boolean
    add_column :availability, :profile_id, :integer
  end
end
