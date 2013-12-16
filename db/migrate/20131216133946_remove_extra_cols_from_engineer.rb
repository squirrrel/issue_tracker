class RemoveExtraColsFromEngineer < ActiveRecord::Migration
  def change
  	remove_column :engineers, :username
  	remove_column :engineers, :password
  end
end
