10.times do |n|
    user_name = Faker::Games::Pokemon.name
    email = Faker::Internet.email(domain: 'example')
    password = "password"
    User.create!(user_name: user_name,
                 email: email,
                 password: password,
                 )
  end
  
  User.create!(user_name: "moeka", email: "moeka@g.com", password: "111111", password_comfirmation: "111111" )