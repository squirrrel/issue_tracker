require 'spec_helper'
require 'capybara/rspec'

# describe '/client/issue_ticket/new' do
# 	it 'should have all of the necessary fields. A ticket should be created after the valid data submission' do
# 		placeholder = [
# 			'Name...', 'Email address...', 'Department', 
# 			'Subject', 'Describe your enquiry here...'
# 		]
# 		visit '/client/issue_ticket/new'
  
# 		page.find('h3').text.should == 	"Describe your issue and submit to our engineers." + 
# 																		" We will provide you with an update within 24 hours"
#   end
# end

#go to sign up page, register, check homepage, sign out, check sign in page, sign in, check it is redirected to homepage
describe '/issue_manager/signin' do
	it '' do
		visit '/issue_manager/signin'
		page.should have_content 'Sign in'
		within 'form#new_engineer' do
			page.should have_selector "input[type='email']"
			page.should have_selector "input[type='password']"
			page.should have_selector "input[type='submit']"
		end
		#(find_link('Sign up').is_a? Element).should == true
		page.should have_selector(:link_or_button, 'Sign up')
		page.should have_selector(:link_or_button, 'Forgot your password?')

		click_on 'Sign up'
		current_path.should eq '/issue_manager/registration'
		page.should have_content 'Sign up'
		within 'form#new_engineer' do
			page.should have_selector "input[type='email']"
			page.should have_selector "input[type='password']"
			page.should have_selector "input[placeholder='password_confirmation']"
			page.should have_selector "input[type='submit']"
		end

		click_on 'Sign in'
		current_path.should eq '/issue_manager/signin'
		Engineer.create(email: 'qwerty@mail.com', password: 'comandante')
		within 'form#new_engineer' do
			fill_in 'email', with: 'qwerty@mail.com'
			fill_in 'password', with: 'comandante' 
		end	
		click_on 'Sign in'
		current_path.should eq root_path
		page.should have_content 'Manage the incoming issues with ease:)'
		page.should have_selector(:link_or_button,'New unassigned tickets')
		page.should have_selector(:link_or_button,'Open tickets')
		page.should have_selector(:link_or_button,'On hold tickets')
		page.should have_selector(:link_or_button,'Closed tickets')
		page.should have_selector(:link_or_button,'Sign out')
	end	
end 