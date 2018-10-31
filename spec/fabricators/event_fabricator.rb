Fabricator(:event) do
  title { 'Event title' }
  category { 'football' }
  location { 'POINT(114.2219923 22.3129115)' }
  start_time { Faker::Time.forward(0, :evening) }
  end_time { Faker::Time.forward(1, :all) }
  cost { 5.5 }
  capacity { 15 }
end