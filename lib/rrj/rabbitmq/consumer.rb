# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an consumer peer users to services used
  class Consumer < Bunny::Consumer
    # Intialize an consumer
    def initiliaze(identifier, opt_consumer)
      channel = opt_consumer['channel']
      queue = channel.queue(opt_copnsumer['queue'])
      super(channel, queue, identifier)
    end
  end
end
