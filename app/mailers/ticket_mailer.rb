class TicketMailer < ApplicationMailer
  def ticket_created(ticket)
    @ticket = ticket
    mail(
      to: @ticket.customer.email,
      subject: "Your ticket has been created"
    )
  end
end