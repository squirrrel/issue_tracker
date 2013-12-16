class CreateEngineers < ActiveRecord::Migration
  def change
    create_table :engineers do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
