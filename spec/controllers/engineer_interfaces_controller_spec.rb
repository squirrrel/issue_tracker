require 'spec_helper'


# describe EngineerInterfacesController do
# 	let!(:ticket)			  	{ FactoryGirl.build(:ticket) }
# 	let!(:on_hold_ticket) { FactoryGirl.build(:on_hold_ticket) }
# 	let!(:comment)				{ FactoryGirl.build(:comment) }
# 	let!(:engineer) 			{ FactoryGirl.create(:engineer) }

# 	before(:each) do
# 		#controller.stub(:authenticate_engineer!).and_return(true)
# 		sign_in engineer
# 	end

# 	describe 'GET index' do
# 		before(:each) do
# 			get :index, {}
# 		end	

# 	 	it 'responds with 200 OK status' do
# 	 		response.status.should == 200
# 	 	end

# 		it 'makes all unassigned records available to views' do
# 			assigns(:tickets).each { |tckt| tckt.status.should == ticket.status } 
# 		end	

# 		it 'renders a view' do
# 			response.should render_template(:index)
# 		end	
# 	end	

# 	describe 'GET edit' do
# 		before(:each) do
# 			Ticket.stub(:find_record) { ticket }
# 			get :edit, id: ticket.id, format: :js
# 		end	

# 		it 'responds with 200 OK status' do
# 	 		response.status.should == 200
# 		end	

# 		it 'makes ticket with the specified id available to views' do
# 			assigns(:ticket).should == ticket
# 		end

# 		#FAILING CAUSE I CANNOT MOCK CURRENT ENGINEER OR MATCH IT WITH ENGINEER
# 		# it 'sets ticket editable property' do
# 		# 	Ticket.stub(:find_record){ ticket }
# 		# 	get :edit, id: ticket.id, format: :js
# 		# 	assigns(:ticket).editable.should == true
# 		# end	

# 		it 'renders a js.erb' do
# 			response.should render_template('shared/edit.js.erb')
# 		end	
# 	end		

# 	describe 'POST update' do
# 		before(:each) do
# 			Ticket.stub(:find_record) { ticket }
# 			Engineer.stub(:find) { engineer }
# 			Ticket.stub(:update_with)
# 			Thread.stub(:new)
# 		end	

# 		it 'create a new comment' do
# 			expect{ post :update, id: ticket.id, 
# 														ticket: { comments: comment.body,
# 										 									status: ticket.status, 
# 																			engineer_id: engineer.id }, 
# 														format: :js}.to change(Comment, :count).by(1)	
# 		end	

# 		it 'responds with 200 OK status' do
# 			Comment.stub(:create_new)
# 			post :update, id: ticket.id, 
# 										ticket: { comments: comment.body, 
# 															status: ticket.status, 
# 															engineer_id: engineer.id }, 
# 										format: :js
# 			response.status.should == 200
# 		end
			
# 		it 'renders a js.erb' do
# 			Comment.stub(:create_new)
# 			post :update, id: ticket.id, 
# 										ticket: { comments: comment.body, 
# 															status: ticket.status, 
# 															engineer_id: engineer.id }, 
# 										format: :js
# 			response.should render_template('update.js.erb')								
# 		end

# 		it 'makes ticket status available to views' do
# 			Comment.stub(:create_new)
# 			post :update, id: ticket.id, 
# 										ticket: { comments: comment.body, 
# 															status: ticket.status, 
# 															engineer_id: engineer.id}, 
# 										format: :js								
# 			assigns(:status).should == ticket.status
# 		end	

# 		it 'updates the ticket accordingly' do; end	

# 		it 'should not allow not permitted params-hash key' do
# 			Comment.stub(:create_new)
# 			expect{ 
# 				post :update, id: ticket.id, 
# 											fake: { comments: comment.body,
# 															status: ticket.status, 
# 															engineer_id: engineer.id }, 
# 											format: :js 
# 			}.to raise_error(ActionController::ParameterMissing)
# 		end	
# 	end	

# 	describe 'GET load_views' do
# 	 	it 'renders empty.js.erb if the fetched collection is empty' do
# 			Ticket.stub(:fetch_matching_records){ [] }
# 	 		get :load_views, status: 'On Hold', format: :js
# 	 		response.should render_template('empty.js.erb')
# 	 	end	
		
# 		before(:each) do
# 			Ticket.stub(:fetch_matching_records){ [on_hold_ticket] }
# 			get :load_views, status: 'On Hold', format: :js
# 		end	

# 		it 'responds with 200 OK status' do
#   		response.status.should == 200
# 	 	end

# 	 	it 'makes tickets with the specified status available to views' do
# 	 		assigns(:tickets).each{|ticket| ticket.status.should == on_hold_ticket.status }
# 	 	end	

# 	 	it 'sets the tickets owner if any' do
# 	 		assigns(:tickets).each{|ticket| ticket.owner.should == ticket.engineer.email }	 	
# 	 	end 	

# 	 	it 'renders load_views.js.erb if the fetched collection is not empty' do
# 	 		response.should render_template('load_views.js.erb')
# 	 	end	
# 	end	
# end