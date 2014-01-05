class Ticket
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic #this is for extra fields dynamically set
	field :ref_number,				type: String
  field :customer_name,			type: String
  field :customer_email,		type: String
  field :department,				type: String
  field :subject, 					type: String
  field :body, 							type: String
  field :created_at,				type: Time, default: ->{ Time.now }
  field :engineer_id,				type: Integer
  field :status,						type: String
  #field :special,						type: String
  validates :customer_name, 	presence: true
  validates :customer_email, 	presence: true
  validates :department, 			presence: true
  validates :subject, 				presence: true
  validates :body,  					presence: true

	attr_accessor :editable, :owner

	def self.create_new permitted_params
		unique_identifier = "#{generate_random_string}-#{generate_random_number}-#{generate_random_string}-" \
								"#{generate_random_number}-#{generate_random_string}"
		create!(
			ref_number: unique_identifier,
			customer_name: permitted_params[:customer_name],
			customer_email: permitted_params[:customer_email],
			department: permitted_params[:department],
			subject: permitted_params[:subject],
			body: permitted_params[:body],
			status: 'Waiting for Staff Response',
			#special: 'sss'
		)
	end	

	def self.all_unassigned
		where(status: 'Waiting for Staff Response')
	end	

	def self.fetch_matching_records status
		where(status: status).order_by([:created_at, :desc]) 
	end	

	def self.find_record id
		find(id)
	end	

	def self.update_with id, ticket_updates, current_engineer_id
    status_for_update = 
      if ticket_updates[:engineer_id] != current_engineer_id && ticket_updates[:status] == 'Waiting for Staff Response'
  	    'On Hold'
      else
        ticket_updates[:status]
      end 
		find(id).update_attributes(engineer_id: ticket_updates[:engineer_id], 
																status: status_for_update) 

	end	

  	def set_editable current_engineer
  		@editable = 
  			if current_engineer.is_a? Engineer
  				self.engineer_id == current_engineer.id  || self.engineer_id.nil? ? (true) : false
  			elsif current_engineer.nil?
  				false
  			end	
  	end

  	def set_owner
  		@owner = self.try(:engineer).try(:email)
  	end	

	private

		def self.generate_random_number
			(0...3).map{ rand(0...9) }.join 
		end

		def self.generate_random_string 
			alphabet = [('A'..'Z')].map{|i| i.to_a }.flatten
  			random_string = (0...3).map{ alphabet[rand(alphabet.length)] }.join
		end
end