source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'activerecord-postgis-adapter'

#https://medium.com/@mazik.wyry/rails-5-api-jwt-setup-in-minutes-using-devise-71670fd4ed03
gem 'devise-jwt'

#https://github.com/twilio/authy-devise
#gem 'devise-authy'

gem 'rswag'

group :development, :test do
  #https://www.fabricationgem.org/
  gem 'fabrication'
  #https://github.com/stympy/faker
  gem 'faker'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
  #https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
end

#https://github.com/flood-io/ruby-jmeter
gem 'ruby-jmeter'