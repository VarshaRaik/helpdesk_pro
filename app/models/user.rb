class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :role, { customer: 0, agent: 1, admin: 2 }
  has_many :created_tickets,
           class_name: "Ticket",
           foreign_key: :customer_id,
           dependent: :destroy

  has_many :assigned_tickets,
           class_name: "Ticket",
           foreign_key: :agent_id

  has_many :comments, dependent: :destroy
end
