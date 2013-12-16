class AddCommentsToTickets < ActiveRecord::Migration
  def change
  	 add_reference :comments, :ticket, index: true
  end
end
