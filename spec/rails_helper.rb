ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'

RSpec.configure do |config|

  # default mock framework
  config.mock_with :rspec

  config.include Rails.application.routes.url_helpers

  # add factory girl
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include(Module.new do
    def stub_api_for(klass)
     klass.use_api (api = Her::API.new)

     # Here, you would customize this for your own API (URL, middleware, etc)
     # like you have done in your application’s initializer
     api.setup url: 'https://itunes.apple.com' do |c|
       c.use Her::Middleware::FirstLevelParseJSON
       c.adapter(:test) { |s| yield(s) }
     end
    end
  end)

end
