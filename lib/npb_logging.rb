module NpbLogging

  require 'npb_logging/config.rb'
  require 'npb_logging/log_subscriber.rb'
  require 'npb_logging/subscriptions.rb'

	# Using model from Lograge @ https://github.com/roidrage/lograge/
  def self.setup
    puts "Setting up our own logging controller"
    # This overwrites the rack method that prints "Started ...."
    require 'npb_logging/rails_ext/rack/logger'
    require 'npb_logging/rails_ext/action_controller/instrumentation'
    
    Subscriptions.remove_existing_log_subscriptions
    LogSubscriber.attach_to :action_controller
  end

end
