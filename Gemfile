source 'https://rubygems.org'

# Ruby Version
# ruby "2.2.1"

# Adding Sinatra Drivers
gem 'sinatra'
gem 'sinatra-contrib'

# Adding thin gem as advised
gem 'thin'

# Adding ActiveRecord and Database Components
gem 'activerecord'
gem 'activesupport'
gem 'sinatra-activerecord'

# Adding Database elements
gem 'pg'

# Adding rake for management
gem 'rake'

# Adding rspec for running unit testing
gem 'rspec'

group :development, :test do
	# Adding shotgun for local web hosting
	gem 'shotgun'
end

group :production do
	# Heroku
	# ==================
	gem 'rails_12factor' # Heroku Gem Supports
	gem 'puma' # Using puma for
	#include faker 
	gem 'faker', '~> 1.6', '>= 1.6.6'
end

gem "eventmachine", "1.0.9"

gem 'bcrypt', '~> 3.1.7'

gem 'byebug'

#putting constraint on which parameter are allowed for each rout
gem 'sinatra-strong-params'

#flash notice
gem 'rack-flash3'

#include faker 
gem 'faker', '~> 1.6', '>= 1.6.6'

#will-paginate
gem 'will_paginate', '~> 3.1.1'


