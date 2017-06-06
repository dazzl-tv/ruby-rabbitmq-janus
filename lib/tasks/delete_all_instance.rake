# frozen_string_literal: true

namespace :rrj do
  desc 'Delete all instances in database.'
  task delete_instances: :environment do
    @timelaps = Time.now.utc

    RubyRabbitmqJanus::Models::JanusInstance.destroy_all

    Rails.logger.info "Executed in #{Time.now.utc - @timelaps} ms"
  end
end
