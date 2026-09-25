class Ticket < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :agent, class_name: "User", optional: true
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many_attached :attachments
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

  scope :by_status, ->(status) {
    where(status: status) if status.present?
  }

  scope :by_priority, ->(priority) {
    where(priority: priority) if priority.present?
  }

  def self.ransackable_attributes(_auth_object = nil)
    [
      "agent_id",
      "category_id",
      "created_at",
      "customer_id",
      "description",
      "id",
      "priority",
      "status",
      "title",
      "updated_at"
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    [
      "agent",
      "attachments_attachments",
      "attachments_blobs",
      "category",
      "comments",
      "customer"
    ]
  end
end
