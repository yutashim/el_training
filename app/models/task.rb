class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true, length: {maximum: 255 }
end
