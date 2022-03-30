source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'

gem 'pg', '~> 1.1.3'
gem 'composite_primary_keys', '~> 11.0'

gem 'bcrypt', '~> 3.1.7'
gem 'pundit', '~> 2.0.0'

gem 'acts_as_api_authable', git: "https://github.com/lordmortis/acts_as_api_authable.git", ref: "c354ae49"

gem 'uuidtools', '~> 2.1.5'
gem 'active_model_serializers', '~> 0.10.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use Puma as the app server
  gem 'puma', '~> 4.3'
end

group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'letter_opener'

  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
