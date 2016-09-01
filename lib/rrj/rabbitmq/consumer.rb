# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an consumer peer users to services used
  class Consumer < Bunny::Consumer
    # Intialize an consumer
    def initiliaze(logs, identifier, opt_consumer)
      @logs = logs
      super(opt_consumer['channel'], opt_consumer['queue'], identifier)
      @logs.info "Consumer id : #{consumer_tag}"
    end
  end
end
