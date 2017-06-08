# frozen_string_literal: true

namesapce :rrj do
  namespace :delete do
    desc 'Delete all instances disable in database'
    task unless_instance: :environment do
    timelaps = Time.now.utc

    RubyRabbitmqJanus::Models::JanusInstance.find_by(enable: false).delete_all

    Rails.logger.info "Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
