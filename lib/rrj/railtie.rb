# frozen_string_literal: true

module RubyRabbitmqJanus
  # # Rake Action
  #
  # Create an action for rails apps
  class Railtie < Rails::Railtie
    railtie_name :rrj

    rake_tasks do
      tasks = File.join(File.dirname(__FILE__), '../tasks', '*.rake')
      Dir[tasks].each { |file_task| load file_task }
    end
  end
end
