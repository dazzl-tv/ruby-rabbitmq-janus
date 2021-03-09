# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in Option class
      class BaseTools < RRJError
        def initialize(message, level = :fatal)
          super("[Tools][Config]#{message}", level)
        end
      end

      module Config
        class QueueFrom < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super '[QueueFrom] Error for reading standard queue from'
          end
        end

        class QueueTo < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super '[QueueTo] Error for reading standard queue to'
          end
        end

        class QueueAdminFrom < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super '[QueueAdminFrom] Error for reading admin queue from'
          end
        end

        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super '[QueueAdminTo] Error for reading admin queue to'
          end
        end

        class Plugins < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super "[Plugins] Error for reading plugins at #{index}"
          end
        end

        class AdminPassword < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize
            super '[AdminPassword] Error for reading option admin password', :warn
          end
        end

        class Rabbitmq < RubyRabbitmqJanus::Errors::Tools::BaseTools
          def initialize(value)
            super "[RabbitMQConfig] Missing RabbitMQ configuration for key : #{value}", :fatal
          end
        end
      end
    end
  end
end
