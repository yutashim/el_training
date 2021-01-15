class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  after_destroy :maintain_admin_user
  after_update :maintain_admin_user
  private
  def maintain_admin_user
    if User.find_by(admin: true) == nil
      loop {
        email = SecureRandom.alphanumeric(6)
        user = User.new(
          name: 'admin_user',
          email: "#{email}@email.com",
          password: 'password',
          password_confirmation: 'password',
          admin: true
        )
        break if user.save
      }
    end
  end
end
