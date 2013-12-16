class AddEngineerToTickets < ActiveRecord::Migration
  def change
  	 add_reference :tickets, :engineer, index: true
  end
end
