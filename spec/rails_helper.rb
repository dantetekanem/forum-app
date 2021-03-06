# frozen_string_literal: true

require "spec_helper"
require "database_cleaner"

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all
  config.include ActiveSupport::Testing::TimeHelpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.use_transactional_fixtures = true

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.infer_spec_type_from_file_location!

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
