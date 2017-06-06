# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define a super class for all error in class Config
      class BaseConfig < BaseTools
        def initialize(message, level = :fatal)
          msg = "[Config] #{message} -- #{Tools::Log.instance.configuration}"
          super(msg, level)
        end
      end

      module Config
        # Error for Config#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error in initalizer'
          end
        end

        # Error for Config#queue_from
        class QueueFrom < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading standard queue from'
          end
        end

        # Error for Config#queue_to
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

        # Error for Config#queue_admin_to
        class QueueAdminTo < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading admin queue to'
          end
        end

        # Error for Config#log_level
        class LevelNotDefine < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading option level', :warn
          end
        end

        # Error for Config#time_to_live (or #ttl)
        class TTLNotFound < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Keepalive TTL option is not reading in config file', :warn
          end
        end

        # Error for Config#plugin_at
        class PluginAt < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize(parameter)
            super 'Plugin is not found in configuration file, ' \
                  "with parameter #{parameter}", :warn
          end
        end

        # Error for Config#cluster
        class Cluster < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading cluster enabled option', :fatal
          end
        end

        # Error for Config#number_of_instance
        class NumberOfinstance < RubyRabbitmqJanus::Errors::Tools::BaseConfig
          def initialize
            super 'Error for reading cluster instance count', :fatal
          end
        end
      end
    end
  end
end
