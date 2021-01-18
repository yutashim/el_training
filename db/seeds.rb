# heroku run rails c で実行
# Task.all.each do |task|
#   task.update(user: User.first)
# end
10.times do
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )

  title = Faker::TvShows::Simpsons.location
  detail = Faker::TvShows::Simpsons.quote
  user = User.last
  Task.create!(
    title: title,
    detail: detail,
    user: user
  )

  label_title = Faker::Creature::Dog.sound
  Label.create!(
    title: label_title
  )
end
