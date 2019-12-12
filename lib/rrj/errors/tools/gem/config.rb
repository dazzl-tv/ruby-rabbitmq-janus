# frozen_string_literal: true

# :reek:IrresponsibleModule

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Tools
      class BaseConfig < BaseTools
        def initialize(message, level = :fatal)
          super("[Config]#{message}", level)
        end
      end

      module Config
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[Initialize] Error when initialize configuration to RRJ Gem'
          end
        end

        class QueueFrom < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[QueueFrom] Error for reading standard queue from'
          end
        end

        class QueueTo < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[QueueTo] Error for reading standard queue to'
          end
        end

        class QueueAdminFrom < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[QueueAdminFrom] Error for reading admin queue from'
          end
        end

        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[QueueAdminTo] Error for reading admin queue to'
          end
        end

        class LogLevel < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[LogLevel] Error for reading option level', :warn
          end
        end

        class LogLevelRabbit < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[LogLevelRabbit] Error for reading option level for rabbitmq', :warn
          end
        end

        class AdminPassword < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[AdminPassword] Error for reading option admin password', :warn
          end
        end

        class TimeToLive < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[TimeToLive] Keepalive TTL option is not reading in config file', :warn
          end
        end

        class PluginAt < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize(parameter)
            super "[PluginAt] Plugin is not found in configuration file, with parameter #{parameter}", :warn
          end
        end

        class Cluster < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize(parameter)
            super "[Cluster] Cluster parameter is missing, with parameter #{parameter}", :warn
          end
        end

        class LogType < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[LogType] Error with Log Type', :fatal
          end
        end

        class LogOption < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[LogOption] Error with Log Option', :fatal
          end
        end

        class Environment < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[Environment] Error with environment option', :fatal
          end
        end

        class ORM < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[ORM] Error with Object Relational Mapping option', :fatal
          end
        end

        class ProgramName < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super '[ProgramName] Error with ProgramName option', :fatal
          end
        end

        class Rabbitmq < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize(value)
            super "[RabbitMQConfig] Missing RabbitMQ configuration for key : #{value}", :fatal
          end
        end
      end
    end
  end
end
