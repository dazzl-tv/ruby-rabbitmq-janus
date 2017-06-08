# frozen_string_literal: true

namespace :rrj do
  namespace :delete do
    desc 'Delete all instances in database'
    task all_instances: :environment do
      timelaps = Time.now.utc

      RubyRabbitmqJanus::Models::JanusInstance.destroy_all

      Rails.logger.info "Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
