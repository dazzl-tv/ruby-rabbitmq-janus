# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        module Admin
          class Base < RubyRabbitmqJanus::Errors::BaseJanus
            def initialize(message)
              super 'Admin', message
            end
          end

          class Sessions < Base
            def initialize
              super "Missing key 'sessions'"
            end
          end

          class Handles < Base
            def initialize
              super "Missing key 'handles'"
            end
          end

          class Info < Base
            def initialize
              super "Missing key 'info'"
            end
          end

          class LibniceDebug < Base
            def initialize
              super "Missing key 'libnice_debug'"
            end
          end

          class LockingDebug < Base
            def initialize
              super "Missing key 'locking_debug'"
            end
          end

          class LogColors < Base
            def initialize
              super "Missing key 'log_color'"
            end
          end

          class Level < Base
            def initialize
              super "Missing key 'log_level'"
            end
          end

          class LogTimestamps < Base
            def initialize
              super "Missing key 'log_timestamps'"
            end
          end

          class MaxNackQueue < Base
            def initialize
              super "Missing key 'max_nack_queue'"
            end
          end

          class NoMediaTimer < Base
            def initialize
              super "Missing key 'no_media_timer'"
            end
          end

          class Timeout < Base
            def initialize
              super "Missing key 'session_timeout'"
            end
          end
        end
      end
    end
  end
end
