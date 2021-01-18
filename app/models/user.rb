class User < ApplicationRecord
  before_update :ensure_admin, if: :edt?
  before_destroy :ensure_admin, if: :dst?
  has_many :tasks, dependent: :destroy
  has_secure_password

  private
  def edt?
    User.find(self.id).admin
  end
  def dst?
    self.admin
  end
  def ensure_admin
    if User.where(admin: true).size == 1
      errors.add(:base, "don't edit/destoy")
      throw(:abort)
    end
  end
end
