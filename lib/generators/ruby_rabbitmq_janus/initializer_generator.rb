# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a initializer
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'

      # Create an initializer
      def copy_initializer
        initializer 'ruby_rabbitmq_janus.rb' do
          "# frozen_string_literal: true\n\n" \
            "::RRJ = RubyRabbitmqJanus::RRJ.new\n"\
            '::Events = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance'
        end
      end
    end
  end
end
