# frozen_string_literal: true

module RubyRabbitmqJanus
  module Models
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Store instance information for MongoID database
    class JanusInstance < ::ActiveRecord::Base
      include RubyRabbitmqJanus::Models::JanusInstanceConcern

      before_destroy { destroy_before_action }
    end
  end
end
