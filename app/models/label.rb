class Label < ApplicationRecord
  has_many :labelings
  has_many :taksk, through: :labelings
end
