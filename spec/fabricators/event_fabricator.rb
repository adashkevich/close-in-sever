Fabricator(:event) do
  title { Faker::Fallout.location }
  category { ['other', 'meeting', 'football', 'basketball', 'volleyball', 'freewalkingtours'].sample }
  location { "POINT(#{Faker::Number.between(53.842607, 53.950685)} #{Faker::Number.between(27.443041, 27.671694)})"  }
  start_time { Faker::Time.between(Date.new(2018, 10, 7), Date.new(2018, 10, 7), :all) }
  end_time { Faker::Time.between(Date.new(2018, 10, 8), Date.new(2018, 10, 8), :all) }
  cost { Faker::Number.decimal(2) }
  capacity { Faker::Number.between(3, 100) }
end