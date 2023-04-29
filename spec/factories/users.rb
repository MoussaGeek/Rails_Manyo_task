FactoryBot.define do
  factory :user do
    user_name { "一般ユーザー" }
    email { "general@ex.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
  factory :second_user, class: User do
    user_name { "管理ユーザー" }
    email { "admin@ex.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
