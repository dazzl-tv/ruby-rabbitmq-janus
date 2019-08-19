# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format for Admin request.
      # Manage level, debug and admin_secret
      #
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Admin < Handle
        private

        KEY_ACCEPTED = %w[colors
                          debug
                          level
                          filename
                          folder
                          max_nack_queue
                          no_media_timer
                          timestamps
                          token
                          truncate
                          timeout].freeze

        def replace_element_classic
          super
          replace_admins if request.key?('admin_secret')
          add_secret if opts.key?('add')
        end

        def add_secret
          values = opts['add']
          request.merge!(values)
        end

        def replace_admins
          replace_admin
          KEY_ACCEPTED.each do |key|
            replace_component(key) if request.key?(key)
          end
        end

        def replace_component(key)
          request[key] = type.convert(key, opts)
        rescue => exception
          Tools::Log.instance.warn "Error replace #{key} : #{exception}"
        end

        def replace_admin
          request['admin_secret'] = Tools::Config.instance.options.admin_pass
        rescue => exception
          Tools::Log.instance.warn "Error replace admin_secret : #{exception}"
        end
      end
    end
  end
end
