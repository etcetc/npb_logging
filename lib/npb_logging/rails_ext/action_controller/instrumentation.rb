module ActionController
  module Instrumentation

    def process_action(*args)
      raw_payload = {
        :controller => self.class.name,
        :action     => self.action_name,
        :params     => request.filtered_parameters,
        :format     => request.format.try(:ref),
        :method     => request.method,
        :path       => (request.fullpath rescue "unknown"),
        :xhr        => request.xhr?,
        :ip         => request.remote_ip,
        :session    => request.session
      }

      ActiveSupport::Notifications.instrument("start_processing.action_controller", raw_payload.dup)

      ActiveSupport::Notifications.instrument("process_action.action_controller", raw_payload) do |payload|
        result = super
        payload[:status] = response.status
        append_info_to_payload(payload)
        result
      end
    end

  end
end