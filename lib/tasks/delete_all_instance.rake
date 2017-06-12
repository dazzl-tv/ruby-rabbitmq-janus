# frozen_string_literal: true

namespace :rrj do
  namespace :delete do
    desc 'Delete all instances in database and janus'
    task all_instances: :environment do
      tags = '[RubyRabbitmqJanus][rrj:delete:all_instances] '
      timelaps = Time.now.utc

      Rails.logger.info "#{tags}Delete all instances"

      RubyRabbitmqJanus::Models::JanusInstance.destroy_all

      Rails.logger.info "#{tags}Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
