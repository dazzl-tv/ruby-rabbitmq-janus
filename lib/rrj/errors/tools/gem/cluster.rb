# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Tools::Option class
      class BaseCluster < BaseTools
        def initialize(message, level = :fatal)
          super("[Cluster] #{message}", level)
        end
      end

      module Cluster
        # Error for Tools::Option#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initialize
            super 'Error in initializer', :fatal
          end
        end

        # Error for Tools::Option#create_sessions
        class CreateSessions < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initalize
            super 'Error for creating sessions'
          end
        end

        # Error for Tools::Option#queue_to
        class QueueTo < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initalize
            super 'Error for create string queue_to'
          end
        end

        # Error for Tools::Option#queue_admin_to
        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initalize
            super 'Error for create string queue_admin_to'
          end
        end
      end
    end
  end
end
