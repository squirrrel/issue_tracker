class AddNullConstraintsToComments < ActiveRecord::Migration
  def change
  	change_column :comments, :body, :text, :null => false
  	change_column :comments, :current_user_or_customer_name, :string, :null => false
  end
end
