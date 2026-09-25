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

  def self.ransackable_attributes(_auth_object = nil)
    [
      "active",
      "created_at",
      "email",
      "id",
      "name",
      "phone",
      "role",
      "updated_at"
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["assigned_tickets", "comments", "created_tickets"]
  end
end

