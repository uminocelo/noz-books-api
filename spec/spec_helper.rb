# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Use the specified formatter
  config.formatter = :documentation

  # Use color in STDOUT
  config.color = true

  # Use the specified Rails environment
  ENV['RAILS_ENV'] = 'test'

  # Load the Rails environment
  require File.expand_path('../../config/environment', __FILE__)

  # Load support files
  Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

  # Load the Rails application
  Rails.application.load_tasks
  Rails.application.load_seed

  # Set up the database
  ActiveRecord::Migration.maintain_test_schema!
  config.use_transactional_fixtures = true

  config.mock_with :rspec
end
