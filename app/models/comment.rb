require 'couchrest_model'

class Comment < CouchRest::Model::Base
	property :current_user_or_customer_name, String
  property :body,        									 String                 
  property :ticket_id,										 String
  timestamps!  

	validates :body, presence: true

	def self.create_new ticket_id, permitted_params, author_name
		create!(
      ticket_id: ticket_id, 
      body: permitted_params[:comments], 
      current_user_or_customer_name: author_name
    )
	end
end