class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true, length: {maximum: 255 }
end
