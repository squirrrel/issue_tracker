class Comment
	include Mongoid::Document
  field :current_user_or_customer_name, type: String
  field :body,                          type: String
  field :created_at,										type: Time, default: ->{ Time.now } 		
  field :ticket_id,											type: Integer

	def self.create_new ticket_id, permitted_params, author_name
		create!(
			ticket_id: ticket_id, 
			body: permitted_params[:comments], 
			current_user_or_customer_name: author_name
		)
	end
end