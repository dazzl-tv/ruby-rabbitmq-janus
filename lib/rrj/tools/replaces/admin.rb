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
          replace_level if request.key?('level')
          replace_debug if request.key?('debug')
        end

        def replace_admin
          request['admin_secret'] = admin_pass
        rescue => message
          Tools::Log.instance.warn "Error replace admin_secret : #{message}"
        end

        def replace_level
          request['level'] = type.convert('level', opts)
        rescue => message
          Tools::Log.instance.warn "Error replace level : #{message}"
        end

        def replace_debug
          request['debug'] = type.convert('debug', opts)
        rescue => message
          Tools::Log.instance.warn "Error replace debug : #{message}"
        end

        def admin_pass
          Tools::Config.instance.options['rabbit']['admin_pass']
        end
      end
    end
  end
end
