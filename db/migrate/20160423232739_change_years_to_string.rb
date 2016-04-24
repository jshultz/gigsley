class ChangeYearsToString < ActiveRecord::Migration
  def change
    change_column :experiences, :years, :string
  end
end
