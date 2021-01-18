class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings
  has_many :labels, through: :labelings
  validates :title, presence: true
  validates :detail, presence: true, length: {maximum: 255 }
  enum priority: [:high, :middle, :low]

  scope :search_tasks, ->(pr) {
    if pr[:word].present? && pr[:status].present?
      title_status_search(pr[:word], pr[:status])
    elsif pr[:word].present?
      title_search(pr[:word])
    elsif pr[:status].present?
      status_search(pr[:status])
    end
  }

  scope :title_status_search, ->(wd, st) {
    tasks = Task.where("title LIKE ?", "%#{wd}%")
    @tasks = tasks.where(status: st)
  }

  scope :title_search, ->(wd) {
    @tasks = Task.where("title LIKE ?", "%#{wd}%")
  }

  scope :status_search, ->(st) {
    @tasks = Task.where(status: st)
  }

  def slice_detail
    if detail.size <= 6
      detail
    else
      "#{detail.slice(0..5)}..."
    end
  end
end
