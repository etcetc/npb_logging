require 'rails/rack/logger'

module Rails
  module Rack
    # Overwrites defaults of Rails::Rack::Logger that cause
    # unnecessary logging.
    # This effectively removes the log lines from the log
    # that say:
    # Started GET / for 192.168.2.1...
    class Logger
      # Overwrites the code that logs new requests.
      # In Rails 3.2.12 the signature changed from 
      # call_app(env) to call_app(request,env)
      def call_app(*args)
        env = args.last
        @app.call(env)
      ensure
        ActiveSupport::LogSubscriber.flush_all!
      end

      # Overwrites Rails 3.0/3.1 code that logs new requests
      def before_dispatch(env)
      end

    end
  end
end