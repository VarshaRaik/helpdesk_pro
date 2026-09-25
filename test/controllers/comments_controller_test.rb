class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @ticket, notice: "Reply added."
    else
      redirect_to @ticket, alert: "Reply can't be blank."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end