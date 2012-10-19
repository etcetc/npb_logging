module NpbLogging
  class LogSubscriber < ActiveSupport::LogSubscriber

    INTERNAL_PARAMS = %w(controller action format _method only_path)

    # This is the event that is called when there is a new event to process
    def start_processing(event)
      payload = event.payload
      params  = payload[:params].except(*INTERNAL_PARAMS)
      format = (extract_format(payload) || "all").to_s.upcase

      logger.info 
      logger.info "===================="
      message = payload[:xhr] ? "AJAX" : ""
      message << "#{format} #{payload[:method]} #{payload[:path]} action=#{payload[:params]['controller']}##{payload[:params]['action']}"

      message << " from #{payload[:ip]}"

      
      message << " [#{extract_user_id(payload)}]"

      logger.info message
      logger.info "params=#{params.inspect}"
    end

    def process_action(event)
      payload = event.payload
      message = "Completed [#{extract_status(payload)}]"
      runtimes = format_runtimes(event) 
      message << (error?(payload) ? "in #{runtimes[:total]}ms" : " in #{runtimes[:total]} (view: #{runtimes[:view]}, db: #{runtimes[:db]})")
      message << " [#{extract_user_id(payload)}]"
      if log_notes =  extract_log_notes(payload) then  message << " {#{log_notes}}" ; end

      logger.info(message)
    end

    private

    def format_runtimes(event)
      {
        :total => "%.1f" % event.duration.to_f,
        :view => "%.1f" % event.payload[:view_runtime].to_f,
        :db => "%.1f" % event.payload[:db_runtime].to_f
      }
    end

    def extract_format(payload)
      if ::ActionPack::VERSION::MINOR == 0
        payload[:formats].first
      else
        payload[:format]
      end
    end

    def error?(payload)
      !!payload[:exception]  
    end

    def extract_status(payload)
      if payload[:status]
        status = payload[:status]
        "#{status} #{Rack::Utils::HTTP_STATUS_CODES[status]}"
      elsif payload[:exception]
        exception, message = payload[:exception]
        "500 error='#{exception}:#{message}'"
      else
        "0"
      end
    end


    def extract_user_id(payload)
      session = payload[:session] and session[:user_id] || session[:tmp_user_id]
    end

    # extract the added log notes
    def extract_log_notes(payload)
      if session = payload[:session] 
        case log_notes = session[:log_notes]
        when Array ; log_notes.join("|")
        when Hash ; log_notes.inspect([]) { |(k,v)| r << "#{k}=#{v.inspect}" }.join("|")
        when String; log_notes
        end
      end
    end

    # Interesting left over from lograge
    def custom_options(event)
      message = ""
      (Lograge.custom_options(event) || {}).each do |name, value|
        message << " #{name}=#{value}"
      end
      message
    end

    def location(event)
      if location = Thread.current[:lograge_location]
        Thread.current[:lograge_location] = nil
        " location=#{location}"
      else
        ""
      end
    end



  end

end

