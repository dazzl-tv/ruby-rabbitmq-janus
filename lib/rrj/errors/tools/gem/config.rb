# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in class Config
      class BaseConfig < BaseTools
        def initialize(message, level = :fatal)
          super("[Config] #{message}", level)
        end
      end

      module Config
        # Error for Tools::Config#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error in initalizer'
          end
        end

        # Error for Tools::Config#queue_from
        class QueueFrom < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading standard queue from'
          end
        end

        # Error for Tools::Config#queue_to
        class QueueTo < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading standard queue to'
          end
        end

        # Error for config#queue_admin_from
        class QueueAdminFrom < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading admin queue from'
          end
        end

        # Error for Tools::Config#queue_admin_to
        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading admin queue to'
          end
        end

        # Error for Tools::Config#log_level
        class LevelNotDefine < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading option level', :warn
          end
        end

        # Error for Tools::Config#log_level
        class LevelRabbitMissing < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading option level for rabbitmq', :warn
          end
        end

        # Error for Tools::Config#time_to_live (or #ttl)
        class TTLNotFound < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Keepalive TTL option is not reading in config file', :warn
          end
        end

        # Error for Tools::Config#plugin_at
        class PluginAt < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize(parameter)
            super 'Plugin is not found in configuration file, ' \
                  "with parameter #{parameter}", :warn
          end
        end
      end
    end
  end
end
