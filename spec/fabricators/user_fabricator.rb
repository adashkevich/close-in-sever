Fabricator(:user, class_name: 'User') do
  phone { Faker::Number.number(7).to_s }
  country_code { '+375' }
  name { Faker::FunnyName.name }
  password { Faker::Internet.password }
end