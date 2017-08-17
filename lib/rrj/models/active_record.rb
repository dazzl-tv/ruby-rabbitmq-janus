# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance < ::ActiveRecord::Base
      include RubyRabbitmqJanus::Models::JanusInstanceMethods
      include RubyRabbitmqJanus::Models::JanusInstanceCallback

      after_create { callback_create_after }
      after_update { callback_update_after }
      before_destroy { callback_destroy_before }
    end
  end
end
