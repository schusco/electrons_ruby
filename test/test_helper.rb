ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
  class ActionDispatch::IntegrationTest
    # This helper wraps every request and injects your token
    def process(method, path, **args)
      args[:params] ||= {}
      # Ensure the token matches what your authenticate_admin! expects
      args[:params][:admin_token] = "test_token_123"
      super(method, path, **args)
    end
  end
end
