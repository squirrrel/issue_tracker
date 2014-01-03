require 'spec_helper'

# describe 'customer_interfaces/new' do
# 	it 'assigns an instance variable and renders a view' do
# 		assign(:ticket, stub_model(Ticket, subject: 'truly important'))
# 		# render
# 		# p rendered
# 		# expect(rendered).to match /truly important/
# 		p render
# 	end	
# end	

describe 'customer_interfaces/show' do
	it '' do
		assign(:ticket, stub_model(Ticket, id: 1, ref_number: 'IDS-187-AUV-866-UGT',
																				customer_name: 'Nina', 
																				customer_email: "someone@gmail.com",
																				department:	'IT',
																				subject: 'Very urgent matter',
																				body:	'Hello, I am bloody desperate',
																				status:	'Waiting for Staff Response'))
		render
		expect(rendered).to match /Nina/
	end	
end	
