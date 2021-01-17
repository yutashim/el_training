FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user_a@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :user_b, class: User do
    name { "user" }
    email { "user_b@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :admin_user, class: User do
    name { "admin_user" }
    email { "admin@email.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
