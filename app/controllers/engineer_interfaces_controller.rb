class EngineerInterfacesController < ApplicationController
  helper :engineer_interface
  before_action :authenticate_engineer!

  def index
    @tickets = Ticket.where(status: :"Waiting for Staff Response")
  end

  def show
  end

  def edit
  	@ticket = Ticket.find params[:id]
    @ticket.editable = @ticket.engineer_id == current_engineer.id  || @ticket.engineer_id.nil? ? (true) : false
    respond_to do |format|
      format.js {render 'shared/edit.js.erb'}
    end  
  end

  def update
    ticket  = Ticket.find(params[:id])
    ticket_updates = params.require(:ticket).permit(:comments, :engineer_id, :status)
    status_for_update = 
          if ticket_updates[:engineer_id] != current_engineer.id && ticket_updates[:status] == 'Waiting for Staff Response'
            :'On Hold'
          else
            ticket_updates[:status]
          end   
    Ticket.update(params[:id], engineer_id: ticket_updates[:engineer_id], status: status_for_update)      
    Comment.create(ticket_id: params[:id], body: ticket_updates[:comments], current_user_or_customer_name: Engineer.find(current_engineer.id).email )
    Thread.new{ CustomerMailer.update_ticket_information(ticket.customer_email, ticket.id).deliver }
    @status = ticket.status
    respond_to do |format|
      format.js { render 'update.js.erb' }
    end  
  end

  def load_views
    @tickets = Ticket.where(status: params[:status]).order('created_at DESC') 
    @tickets.map do |ticket| 
      ticket.owner = ticket.try(:engineer).try(:email)
    end 
    respond_to do |format|
      format.js { render "#{@tickets.empty? ? ('empty.js.erb') : ('load_views.js.erb')}" }
    end    
  end
end