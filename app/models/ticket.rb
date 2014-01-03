class Ticket < ActiveRecord::Base
	attr_accessor :editable, :owner

	belongs_to :engineer
	has_many :comments

	validates :body, presence: true
	validates :customer_name, presence: true
	validates :customer_email, presence: true
	validates :department, presence: true
	validates :subject, presence: true


	def self.create_new permitted_params
		unique_identifier = "#{generate_random_string}-#{generate_random_number}-#{generate_random_string}-" \
								"#{generate_random_number}-#{generate_random_string}"
		permitted_params[:ref_number] = unique_identifier 
		permitted_params[:status] = :"Waiting for Staff Response"
		create(permitted_params)
	end	

	def self.all_unassigned
		where(status: :"Waiting for Staff Response")
	end	

	def self.fetch_matching_records status
		where(status: status).order('created_at DESC') 
	end	

	def self.find_record id
		find(id)
	end	

	def self.update_with id, ticket_updates, current_engineer_id
	    status_for_update = 
          if ticket_updates[:engineer_id] != current_engineer_id && ticket_updates[:status] == 'Waiting for Staff Response'
            :'On Hold'
          else
            ticket_updates[:status]
          end 
		update(id, engineer_id: ticket_updates[:engineer_id], status: status_for_update) 
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