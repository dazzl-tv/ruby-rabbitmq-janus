# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'

      def copy_initializer
        initializer 'ruby_rabbitmq_janus.rb' do
          "# frozen_string_literal: true\n\n::RRJ = RubyRabbitmqJanus::RRJ.new"
        end
      end
    end
  end
end
