class CustomerMailer < ActionMailer::Base
   default from: "from@example.com"

	def create_ticket_information user_email, ticket_id
		@user_email = user_email
		@uri = "localhost:3000/client/issue_ticket/#{ticket_id}" 
		mail(to: @user_email, subject: 'Your ticket has been successfully created')
	end	

	def update_ticket_information user_email, ticket_id
		@user_email = user_email
		@uri = "localhost:3000/client/issue_ticket/#{ticket_id}"
		mail(to: @user_email, subject: 'Your ticket is updated')
	end	
end