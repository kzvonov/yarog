# Load the Rails application.
require_relative "application"

# Enable structured logging for Falcon (optional - enables ActiveRecord query logging)
# Console::Adapter::Rails::ActiveRecord.apply! if defined?(Console)
# it is already enabled 😅

# Initialize the Rails application.
Rails.application.initialize!
