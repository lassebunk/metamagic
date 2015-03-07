# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'hash_from_xml'

Rails.backtrace_cleaner.remove_silencers!

class ActionView::TestCase
  def assert_equal_segment(first, second)
    assert_equal Hash.from_xml(first),  Hash.from_xml(second)
  end
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end
