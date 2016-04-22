class AddJobsIndexToProfiles < ActiveRecord::Migration
  def change
    add_reference :profiles, :jobs, index: true
  end
end
