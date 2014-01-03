class AddNullConstraintsToTicket < ActiveRecord::Migration
  def change
  	change_column :tickets, :ref_number, :string, :null => false
  	change_column :tickets, :customer_name, :string, :null => false
  	change_column :tickets, :customer_email, :string, :null => false
    change_column :tickets, :department, :string, :null => false
    change_column :tickets, :subject, :string, :null => false
    change_column :tickets, :body, :text, :null => false
    change_column :tickets, :status, :string, :null => false
  end
end
