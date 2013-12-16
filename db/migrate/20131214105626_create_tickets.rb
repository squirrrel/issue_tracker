class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :ref_number
      t.string :customer_name
      t.string :customer_email
      t.string :department
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
