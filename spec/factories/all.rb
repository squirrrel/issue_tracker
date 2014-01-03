FactoryGirl.define do
	factory :engineer do
		sequence(:id, 1) 	{ |n| n }
		sequence(:email, 1)     { |n| "new#{n}@new.com" }			
		encrypted_password	'$2a$10$.k9Qp/0u59SoVblOK/NmwOhX9IIg.yk6OyDLaqgceFPj/1y2unxEm'
		password  			   'test1234'
		#has_many tickets	
			 # ignore do
			 # 	tickets_count 5
			 # end	

			 # after(:create) do |engineer, evaluator|
			 # 	create_list :ticket, evaluator.tickets_count, engineer: engineer
			 # end
	end	

	factory :ticket do
		#belongs_to engineer
		engineer
		sequence(:id, 1) 	{ |n| n }
		ref_number						'IDS-187-AUV-866-UGT'
		customer_name					'Nina'
		sequence(:customer_email) 	{ |n| "someone#{n}@gmail.com" }			 
		department						'IT'
		subject							'Very urgent matter'
		body								'Hello, I am bloody desperate'
		status							'Waiting for Staff Response'

		trait :on_hold do
			status 	'On Hold'
		end	

		trait :open do
			status 	'Waiting for Customer'
		end	

		trait :completed do
			status 	'Completed'
		end	

		trait :cancelled do
			status 	'Cancelled'
		end
  		
  		factory :on_hold_ticket,    traits: [:on_hold]
  		factory :open_ticket,		 traits: [:open]
  		factory :completed_ticket,	 traits: [:completed]
  		factory :cancelled_ticket,	 traits: [:cancelled]
		#has_many comments
  #  		ignore do
		# 	comments_count 5
  #      	end

	 #   	after(:create) do |ticket, evaluator|
		# 	create_list :comment, evaluator.comments_count, ticket: ticket
		# end
	end

	factory :comment do
		sequence(:id, 1) 									{ |n| n }
		sequence(:current_user_or_customer_name) 	{ |n| "Nina#{n}" }	
		body 													'It is very boring'
		#belongs_to ticket
		#ticket
	end	
end	