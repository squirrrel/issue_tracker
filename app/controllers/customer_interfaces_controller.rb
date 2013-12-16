class CustomerInterfacesController < ApplicationController
  def new
	@ticket = Ticket.new
  end

  def create 	
	new_ticket = params.require(:ticket).permit(:customer_name, :customer_email, :department, :subject, :body)
 	unique_identifier = "#{generate_random_string}-#{generate_random_number}-#{generate_random_string}-#{generate_random_number}-#{generate_random_string}"
	new_ticket[:ref_number] = unique_identifier 
	new_ticket[:status] = :"Waiting for Staff Response"
	recorded_ticket = Ticket.create(new_ticket)
	Thread.new{ CustomerMailer.create_ticket_information(new_ticket[:customer_email], recorded_ticket.id ).deliver }
	redirect_to action: 'new'
  end

  def show
  	@ticket = Ticket.find(params[:id])
  end	

  def edit
  	@ticket = Ticket.find params[:id]
    @ticket.editable = false
    respond_to do |format|
      format.js {render 'shared/edit.js.erb'}
    end 
  end	

  def update
    new_comment = params.require(:ticket).permit(:comments)
    customer_name = Ticket.find(params[:id]).customer_name
    Comment.create(ticket_id: params[:id], body: new_comment[:comments], current_user_or_customer_name: customer_name)
    @ticket_id = params[:id] 
    respond_to do |format|
      format.js { render 'update.js.erb' }
    end  
  end	

  private

	def generate_random_number
		(0...3).map{ rand(0...9) }.join 
	end

	def generate_random_string 
		alphabet = [('A'..'Z')].map{|i| i.to_a }.flatten
    	random_string = (0...3).map{ alphabet[rand(alphabet.length)] }.join
	end
end