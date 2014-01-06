require 'couchrest_model'

class Ticket < CouchRest::Model::Base
	property  :ref_number,     String
	property  :customer_name,  String
	property  :customer_email, String
	property  :department,     String   
	property  :subject,        String      
	property  :body,           String         
	property  :engineer_id,    String
	property  :status,         String       
	timestamps!

	design do
		view :status_view,
			map:
				"function(doc) {
					if(doc['type'] == 'Ticket' && doc.status) {
						emit(doc.status, doc);
					}
				}"
	end	

	attr_accessor :editable, :owner

	validates :body, presence: true
	validates :customer_name, presence: true
	validates :customer_email, presence: true
	validates :department, presence: true
	validates :subject, presence: true


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
      status: 'Waiting for Staff Response'
    )
	end	

	def self.all_unassigned
		# REFACTOR: this peace along with the next one cut off and put into a single method call 
  	tickets_cursor = Ticket.status_view.rows.map do |row|
  		row.key == 'Waiting for Staff Response' ? (row.value.with_indifferent_access) : (nil)
  	end
		 tickets_cursor.compact
	end	

	def self.fetch_matching_records status
		tickets_cursor = Ticket.status_view.rows.map do |row|
  		row.key == status ? (row.value.with_indifferent_access) : (nil)
  	end
		tickets_cursor.compact
		#where(status: status).order('created_at DESC') 
	end	

	def self.find_record id
		find(id)
	end	

	def self.update_with id, ticket_updates, current_engineer_id
		find(id)
			.update_attributes({engineer_id: ticket_updates[:engineer_id], 
		 											status: ticket_updates[:status]}) 
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