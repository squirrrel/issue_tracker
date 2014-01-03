require 'spec_helper'

# describe Comment do
# 	let!(:engineer) { FactoryGirl.create(:engineer) }
# 	let!(:ticket)   { FactoryGirl.create(:ticket) }
# 	let!(:comment)  { FactoryGirl.create(:comment, current_user_or_customer_name: engineer.email) }

# 	describe 'model validations' do
# 		it 'should have a valid factory' do
# 			FactoryGirl.build(:comment).should be_valid
# 		end	

# 		it 'should require body presence' do
# 			FactoryGirl.build(:comment, body: nil).should_not be_valid
# 		end	
# 	end	

# 	describe '#create_new' do
# 		it 'returns a new record with attribute values equal to input params' do
# 			described_class.should_receive(:create).with(ticket_id: ticket.id, body: comment.body, 
# 																		current_user_or_customer_name: engineer.email).and_return(comment)
# 			described_class.create_new(ticket.id, {comments: comment.body}, engineer.email).should == comment
# 		end	

# 		it 'raises an error if zero param is assigned for non-nullable attribute' do
# 			expect{ described_class.create_new(ticket.id, {comments: comment.body}, nil) }.to raise_error(ActiveRecord::StatementInvalid)
# 		end	
# 	end	
# end