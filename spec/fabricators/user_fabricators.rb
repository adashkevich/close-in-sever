Fabricator(:user) do
  phone { Faker::Number.number(7).to_s }
  country_code { '+375' }
  name { Faker::FunnyName.name }
end