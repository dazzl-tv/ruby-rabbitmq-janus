# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Tools::Option class
      class BaseCluster < BaseTools
        def initialize(message, level = :fatal)
          super("[Cluster]#{message}", level)
        end
      end

      module Cluster
        class CreateSession < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initialize
            super '[CreateSession] Error during create session (just one instance to Janus)'
          end
        end

        class QueueTo < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initialize
            super '[QueueTo] Error for create string queue_to'
          end
        end

        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initialize
            super '[QueueAdminTo] Error for create string queue_admin_to'
          end
        end

        class RestartInstance < RubyRabbitmqJanus::Errors::Tools::BaseCluster
          def initialize
            super '[RestartInstance] Error for restart Janus Instance'
          end
        end
      end
    end
  end
end
