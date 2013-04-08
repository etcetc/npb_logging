require 'rails/rack/logger'

module Rails
  module Rack
    # Overwrites defaults of Rails::Rack::Logger that cause
    # unnecessary logging.
    # This effectively removes the log lines from the log
    # that say:
    # Started GET / for 192.168.2.1...
    class Logger
      # Overwrites Rails 3.2.12 code that logs new requests
      if defined?  :started_request_message
        def started_request_message(request)
          ""
        end
      else
        # Overwrites Rails 3.2 code that logs new requests
        def call_app(env)
          @app.call(env)
        ensure
          ActiveSupport::LogSubscriber.flush_all!
        end
      end

      # Overwrites Rails 3.0/3.1 code that logs new requests
      def before_dispatch(env)
      end

    end
  end
end