ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }
require 'rspec/rails'
require 'support/factory_bot'
require 'shoulda/matchers'

RSpec.configure do |config| 
  config.infer_spec_type_from_file_location!
end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end