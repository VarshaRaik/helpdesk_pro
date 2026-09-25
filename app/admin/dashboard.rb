ActiveAdmin.register_page "Dashboard" do
  content do
    columns do
      column do
        panel "Ticket Statistics" do
          para "Total Tickets: #{Ticket.count}"
          para "Open Tickets: #{Ticket.open.count}"
          para "Resolved Tickets: #{Ticket.resolved.count}"
          para "Urgent Tickets: #{Ticket.urgent.count}"
        end
      end

      column do
        panel "User Statistics" do
          para "Total Users: #{User.count}"
          para "Customers: #{User.customer.count}"
          para "Agents: #{User.agent.count}"
        end
      end
    end

    panel "Recent Tickets" do
      table_for Ticket.order(created_at: :desc).limit(5) do
        column :title
        column :status
        column :priority
        column :created_at
      end
    end
  end
end