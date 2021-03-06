class EngineerInterfacesController < ApplicationController
  helper :engineer_interface
  before_action :authenticate_engineer!

  def index
    @tickets = Ticket.all_unassigned
  end

  def show
  end

  def edit
  	@ticket = Ticket.find_record(params[:id])
    @ticket.set_editable(current_engineer)
    #@ticket.editable = @ticket.engineer_id == current_engineer.id  || @ticket.engineer_id.nil? ? (true) : false
    respond_to do |format|
      format.js { render 'shared/edit.js.erb' }
    end  
  end

  def update
    ticket  = Ticket.find_record(params[:id])
    engineer_email = Engineer.find(current_engineer.id).email #move to comment model at a later time 
    ticket_updates = params.require(:ticket).permit(:comments, :engineer_id, :status)  
    Ticket.update_with(params[:id], ticket_updates, current_engineer.id)      
    Comment.create_new(params[:id], ticket_updates, engineer_email)
    Thread.new { CustomerMailer.update_ticket_information(ticket.customer_email, ticket.id).deliver }
    @status = ticket.status
    respond_to do |format|
      format.js { render 'update.js.erb' }
    end  
  end

  def load_views
    @tickets = Ticket.fetch_matching_records(params[:status])
    @tickets.map do |ticket| 
      ticket.set_owner 
    end 
    respond_to do |format|
      format.js { render "#{@tickets.empty? ? ('empty.js.erb') : ('load_views.js.erb')}" }
    end    
  end
end