User.create(
  name: 'admin_user',
  email: 'ad@email.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

# heroku run rails c で実行
# Task.all.each do |task|
#   task.update(user: User.first)
# end
