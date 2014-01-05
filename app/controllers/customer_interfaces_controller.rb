class CustomerInterfacesController < ApplicationController
  def new
	 @ticket = Ticket.new
  end

  def create 	
  	permitted_params = params.require(:ticket).permit(:customer_name, :customer_email, 
                                                      :department, :subject, :body)
  	recorded_ticket = Ticket.create_new(permitted_params)
    Thread.new { CustomerMailer.create_ticket_information(permitted_params[:customer_email], recorded_ticket.id )
      .deliver }
    redirect_to action: 'new'
  end

  def show
  	@ticket = Ticket.find_record(params[:id])
  end	

  def edit
  	@ticket = Ticket.find_record(params[:id])
    @ticket.editable = true
    respond_to do |format|
      format.js {render 'shared/edit.js.erb'}
    end 
  end	

  def update
    ticket_updates = params.require(:ticket).permit(:comments)
    customer_name = Ticket.find_record(params[:id]).customer_name #move to comment model at a later time 
    Comment.create_new(params[:id], ticket_updates, customer_name)
    @ticket_id = params[:id] 
    respond_to do |format|
      format.js { render 'update.js.erb' }
    end  
  end	
end