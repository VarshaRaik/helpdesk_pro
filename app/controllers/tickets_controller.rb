class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = current_user.created_tickets
                          .by_status(params[:status])
                          .by_priority(params[:priority])
                          .where("title ILIKE ?", "%#{params[:query]}%")
                          .order(created_at: :desc)
  end

  def show
    authorize @ticket
    @comment = Comment.new
  end

  def new
    @ticket = current_user.created_tickets.new
    @categories = Category.all
  end

  def create
    @ticket = current_user.created_tickets.new(ticket_params)

    if @ticket.save
      TicketMailer.ticket_created(@ticket).deliver_later
      redirect_to @ticket, notice: "Ticket successfully create ho gaya."
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket update ho gaya."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path, notice: "Ticket delete ho gaya."
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(
      :title,
      :description,
      :category_id,
      :priority,
      :status,
      attachments: []
    )
  end
end