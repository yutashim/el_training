class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true, length: {maximum: 255 }

  scope :search_tasks, ->(pr) {
    if pr[:word].present? && pr[:status].present?
      tasks = Task.where("title LIKE ?", "%#{pr[:word]}%")
      @tasks = tasks.where(status: pr[:status])
    elsif pr[:word].present?
      @tasks = Task.where("title LIKE ?", "%#{pr[:word]}%")
    elsif pr[:status].present?
      @tasks = Task.where(status: pr[:status])
    end
  }
end
