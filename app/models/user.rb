class User < ApplicationRecord
  before_update :ensure_admin, if: :admin_user?
  before_destroy :ensure_admin, if: :admin_user?
  has_many :tasks, dependent: :destroy
  has_secure_password
  private
  def admin_user?
    self.admin == true
  end

  def ensure_admin
    if User.where(admin: true).size == 0
      errors.add(:base, "don't edit")
      throw(:abort)
    elsif User.where(admin: true).size == 1
      errors.add(:base, "don't destoy")
      throw(:abort)
    end
  end
end
