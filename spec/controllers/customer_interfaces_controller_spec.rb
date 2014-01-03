require 'spec_helper'

describe CustomerInterfacesController do
	render_views
	let!(:ticket)		{ FactoryGirl.build(:ticket) }
	let!(:comment)	{ FactoryGirl.build(:comment) }

	describe 'GET new' do
		before(:each) do
			get :new, {}
		end	

		it 'should respond with 200 OK status' do
			response.status.should == 200
		end
			
		it 'should instantiate the Ticket class and make its object available to views' do
			expect(assigns(:ticket)).to be_a_new(Ticket)
			assigns(:ticket).should be_new_record
		end	

		it 'should render a view' do
			response.should render_template(:new)
		end
	end	

	describe 'POST create' do
		before(:each) do
			Thread.stub(:new)
		end	

		it 'should not allow not permitted params-hash key' do
			expect {
				post :create, { fake: { customer_name: ticket.customer_name, 
																customer_email: ticket.customer_email, 
																department: ticket.department, 
																subject: ticket.subject, 
																body: ticket.body } }
			}.to raise_error(ActionController::ParameterMissing)
		end	

		it 'should create a new tickets table record in the db' do
			expect { 	
				post :create, { ticket: { customer_name: ticket.customer_name, 
																	customer_email: ticket.customer_email, 
																	department: ticket.department, 
																	subject: ticket.subject, 
																	body: ticket.body } }
    	}.to change(Ticket, :count).by(1)
		end	

		before(:each) do
			post :create, { ticket: { customer_name: ticket.customer_name, 
																customer_email: ticket.customer_email, 
																department: ticket.department, 
																subject: ticket.subject, 
																body: ticket.body } }
		end	

		it 'should respond with 200 OK status' do
			response.status.should == 302					
		end	

		it 'redirects back to new' do
			response.should redirect_to action: :new
		end	
	end	
	
	describe 'GET show' do
		before(:each) do
			Ticket.stub(:find_record){ ticket }
			get :show, { id: ticket.id }
		end

		it 'should respond with 200 OK status' do
			response.status.should == 200
		end

		it 'returns the ticket object with the id specified in params and make it available to views' do
			assigns(:ticket).should == ticket
		end	

		it 'renders a view' do
			response.should render_template(:show)
		end
	end	

	describe 'GET edit' do
		before(:each) do
			Ticket.stub(:find_record){ ticket }
			get :edit, id: ticket.id, format: :js
		end
			
		it 'should respond with 200 OK status' do
			response.status.should == 200
		end

		it 'makes ticket with the specified id available to views' do
			assigns(:ticket).should == ticket
		end

		it 'sets ticket editable property' do
			assigns(:ticket).editable.should == false
		end	

		it 'renders a js.erb' do
			response.should render_template('shared/edit.js.erb')
		end	
	end	

	describe 'POST update' do
		it 'should not allow not permitted params-hash key' do
			expect{ post :update, id: ticket.id, 
														fake: { comments: comment }, 
														format: :js }
				.to raise_error(ActionController::ParameterMissing)
		end	

		it 'should create a new comment but we are mocking it' do
			Ticket.stub(:find_record){ ticket }
			expect { 
				post :update, id: ticket.id, 
											ticket: { comments: comment.body }, 
											format: :js
			}.to change(Comment, :count).by(1)
		end

		before(:each) do
			Ticket.stub(:find_record){ ticket }
			post :update, id: ticket.id, ticket: { comments: comment }, format: :js
		end
			
		it 'should respond with 200 OK status' do
			response.status.should == 200
		end

		it 'makes ticket id available for views' do
			assigns(:ticket_id).should == ticket.id.to_s
		end

		it 'renders a js.erb' do
			response.should render_template('update.js.erb')
		end 		
	end	
end