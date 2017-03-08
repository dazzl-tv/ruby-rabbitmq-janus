# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format for Admin request
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Admin < Handle
        private

        # Replace classic elements and for admin elements
        def replace_element_classic
          super
          replace_admins if request.key?('admin_secret')
          add_secret if opts.key?('add')
        end

        # Add string secret for admin request
        def add_secret
          values = opts['add']
          request.merge!(values)
        end

        # Replace elements admins if present
        def replace_admins
          replace_admin
          replace_level if request.key?('level')
          replace_debug if request.key?('debug')
        end

        # Replace admin secret in request
        def replace_admin
          request['admin_secret'] = admin_pass
        rescue => message
          Tools::Log.instance.warn "Error replace admin_secret : #{message}"
        end

        # Replace level element
        def replace_level
          request['level'] = type.convert('level', opts)
        rescue => message
          Tools::Log.instance.warn "Error replace level : #{message}"
        end

        # Replace debug element
        def replace_debug
          request['debug'] = type.convert('debug', opts)
        rescue => message
          Tools::Log.instance.warn "Error replace debug : #{message}"
        end

        # Given a admin pass for request
        def admin_pass
          Tools::Config.instance.options['rabbit']['admin_pass']
        end
      end
    end
  end
end
