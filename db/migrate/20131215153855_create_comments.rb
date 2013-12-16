class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :current_user_or_customer_name
      t.text :body

      t.timestamps
    end
  end
end
