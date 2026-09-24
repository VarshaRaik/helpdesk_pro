class Ticket < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :agent, class_name: "User", optional: true
  belongs_to :category
  has_many :comments, dependent: :destroy
  enum :status, {
    open: 0,
    in_progress: 1,
    resolved: 2,
    closed: 3
  }
  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    urgent: 3
  }

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  scope :active, -> {
    where.not(status: [:resolved, :closed])
  }

  scope :urgent_tickets, -> {
    where(priority: :urgent)
  }
end
