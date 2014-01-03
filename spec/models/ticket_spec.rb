require 'spec_helper'

# describe Ticket do
# 	let!(:ticket)  			{ FactoryGirl.create(:ticket) }
# 	let!(:on_hold_ticket)   { FactoryGirl.create(:on_hold_ticket) }
# 	let!(:open_ticket)		{ FactoryGirl.create(:open_ticket) }
# 	let!(:completed_ticket) { FactoryGirl.create(:completed_ticket) }
# 	let!(:cancelled_ticket) { FactoryGirl.create(:cancelled_ticket) }
# 	let!(:engineer)			{ FactoryGirl.create(:engineer) }

# 	describe 'model validations' do
# 		it 'should have a valid factory' do
# 			FactoryGirl.build(:ticket).should be_valid
# 		end

# 		it 'should require body presence' do
# 			FactoryGirl.build(:ticket, body: nil).should_not be_valid
# 		end	

# 		it 'should require customer_name presence' do
# 			FactoryGirl.build(:ticket, customer_name: nil).should_not be_valid
# 		end
		
# 		it 'should require customer_email presence' do
# 			FactoryGirl.build(:ticket, customer_email: nil).should_not be_valid
# 		end

# 		it 'should require department presence' do
# 			FactoryGirl.build(:ticket, department: nil).should_not be_valid
# 		end

# 		it 'should require subject presence' do
# 			FactoryGirl.build(:ticket, subject: nil).should_not be_valid
# 		end	
# 	end	

# 	describe '#create_new' do
# 		it 'returns a new record with attribute values equal to input params' do
# 			described_class.stub(:generate_random_string)
# 			described_class.stub(:generate_random_number)

# 			permitted_params = { customer_name: ticket.customer_name, customer_email: ticket.customer_email,
# 										 department: ticket.department, subject: ticket.subject, body: ticket.body }
# 			described_class.should_receive(:create).with(permitted_params).and_return(ticket)
# 			described_class.create_new(permitted_params).should eql(ticket)
# 		end

# 	# 	#For some reason this does not work when validations are bound to the model. Why??
# 	#  	# it 'raises an error if zero param is assigned for non-nullable attribute' do
# 	#  	# 	permitted_params = { customer_name: ticket.customer_name, customer_email: ticket.customer_email }
# 	#  	# 	expect{ described_class.create_new(permitted_params) }.to raise_error(ActiveRecord::StatementInvalid)
# 	#  	# end	
# 	end	

# 	describe '#all_unassigned' do
# 	 	it 'returns all tickets with Waiting for Staff Response status' do
# 	 		described_class.should_receive(:where).with(status: :"Waiting for Staff Response").and_return([ticket])
# 	 		described_class.all_unassigned.each{|ticket| ticket.status.should == 'Waiting for Staff Response' }
# 	 	end	

# 	 	it 'returns ActiveRecord::Relation object containing empty array if there are no records with Waiting for Staff Response status' do
# 	 		described_class.should_receive(:where).with(status: :"Waiting for Staff Response").and_return([])
# 	 		described_class.all_unassigned.empty?.should == true
# 	 	end	
# 	end

# 	describe '#fetch_matching_records' do
# 		it 'returns all tickets with Waiting for Staff Response status if query status param is Waiting for Staff Response' do
# 			described_class.should_receive(:where).with(status: :'Waiting for Staff Response').and_return(ticket)
# 			ticket.should_receive(:order).with('created_at DESC').and_return([ticket])
# 			described_class.fetch_matching_records(:'Waiting for Staff Response').each{|ticket| ticket.status.should == 'Waiting for Staff Response' }
# 		end
		
# 		it 'returns all tickets with Waiting for Customer status if query status param is  Waiting for Customer'	do
# 		 	described_class.should_receive(:where).with(status: :'Waiting for Customer').and_return(open_ticket)
# 		 	open_ticket.should_receive(:order).with('created_at DESC').and_return([open_ticket])
# 		 	described_class.fetch_matching_records(:'Waiting for Customer').each{|ticket| ticket.status.should == 'Waiting for Customer'}
# 		end	

# 		it 'returns all tickets with On Hold status if query status param is On Hold'	do
# 		 	described_class.should_receive(:where).with(status: :'On Hold').and_return(on_hold_ticket)
# 		 	on_hold_ticket.should_receive(:order).with('created_at DESC').and_return([on_hold_ticket])
# 		 	described_class.fetch_matching_records(:'On Hold').each{|ticket| ticket.status.should == 'On Hold' }
# 		end	

# 		it 'returns all tickets with Cancelled status if query status param is Cancelled' do
# 		 	described_class.should_receive(:where).with(status: :'Cancelled').and_return(cancelled_ticket)
# 		 	cancelled_ticket.should_receive(:order).with('created_at DESC').and_return([cancelled_ticket])
# 		 	described_class.fetch_matching_records(:'Cancelled').each{|ticket| ticket.status.should == 'Cancelled' }
# 		end

# 		it 'returns all tickets with Completed status if query status param is Completed' do
# 		 	described_class.should_receive(:where).with(status: :'Completed').and_return(completed_ticket)
# 		 	completed_ticket.should_receive(:order).with('created_at DESC').and_return([completed_ticket])
# 		 	described_class.fetch_matching_records(:'Completed').each{|ticket| ticket.status.should == 'Completed' }
# 		end

# 		it 'returns ActiveRecord::Relation object containing empty array if non-existent status specified as query status param' do
# 		 	described_class.should_receive(:where).with(status: :'Test').and_return(nil)
# 		 	nil.should_receive(:order).with('created_at DESC').and_return([])
# 		 	described_class.fetch_matching_records(:'Test').empty?.should == true
# 		end		

# 		it 'returns ordered by create_at DESC field collection' do
# 			fetched_records = described_class.fetch_matching_records(ticket.status)  
# 			fetched_records[0].created_at.should > fetched_records[1].created_at 
# 		end				
# 	end	

# 	describe '#find_record' do
# 		it 'returns a record by an existing id' do
# 			described_class.should_receive(:find).with(ticket.id).and_return(ticket)
# 			described_class.find_record(ticket.id).should eql(ticket)
# 		end
		
# 		it 'raises error if a non-existing id passed' do
# 			expect{ described_class.find_record(1234) }.to raise_error(ActiveRecord::RecordNotFound)
# 		end	
# 	end	

# 	describe '#update_with' do
# 		it 'updates subject ticket according to the parameters specified' do
# 			ticket.engineer_id = 1
# 			ticket.status = 'On Hold'
# 			described_class.stub(:update){ticket}
# 			described_class.update_with(ticket.id, {engineer_id: 1}, 1).should == ticket 
# 		end	
# 	end
	
# 	describe '::set_editable' do
# 		it 'sets the ticket editable for current user/engineer if their id matches its engineer_id' do
# 		 	engineer.id = ticket.engineer_id
# 		 	ticket.set_editable(engineer)
# 		 	ticket.editable.should == true
# 		end	

# 		it 'sets ticket editable if its engineer_id property equals nil' do
# 			ticket.engineer_id = nil
# 			ticket.set_editable(engineer)
# 			ticket.editable.should == true
# 		end	

# 		it 'sets ticket non-editable if current user/engineer id did not match its engineer_id' do
# 			ticket.set_editable(engineer)
# 			ticket.editable.should == false
# 		end	

# 		it 'sets ticket non-editable if nil is passed instead of current engineer object' do
# 			ticket.set_editable(nil)
# 			ticket.editable.should == false
# 		end	

# 		it 'returns nil if any other invalid argument is passed' do
# 		 	ticket.set_editable('test')
# 		 	ticket.editable.should == nil
# 		end	
# 	end

# 	describe '::set_owner' do
# 		it 'sets ticket owner if ticket already belongs to any engineer through engineer_id foreign key' do
# 			ticket.set_owner
# 			ticket.owner.should =~ /^new\d{1,4}@new.com$/
# 		end	

# 		it 'sets owner to nil if ticket does not belong to any engineer' do
# 			ticket.engineer_id = nil
# 			ticket.owner.should == nil
# 		end		
# 	end 	

# 	describe '#generate_random_number' do
# 		it 'returns a random 3-digit number' do
# 			described_class.generate_random_number.should_not == described_class.generate_random_number
# 		end
# 	end

# 	describe '#generate_random_string' do	
# 		it 'returns a random set of 3 letters' do
# 			described_class.generate_random_string.should_not == described_class.generate_random_string
# 		end	
# 	end
# end	