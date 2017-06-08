# frozen_string_literal: true

module RubyRabbitmqJanus
  # Execute this code when janus return an events in standard queue
  class ActionEvents
    # Default method using for sending a block of code
    def actions
      lambda do |reason, data|
        Rails.logger.debug "Execute block code with reason : #{reason}"
        case reason
        when event then case_events(data.to_hash)
        end
      end
    end

    private

    def case_events(data)
      Rails.logger.debug "Event : #{data}"
    end
  end
end
