# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Create an message with type :create.
  # This message create a session betwen janus and customer
  # @example JSON sending
  #   {
  #       "janus" : "create",
  #       "transaction" : "sBJNyUhH6Vc6"
  #   }
  class MessageCreate < MessageBasicJanus
    def initialize
      puts 'MessageCreate initialize'
      super(:create)
    end
  end
end
