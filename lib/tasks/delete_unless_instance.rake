# frozen_string_literal: true

namespace :rrj do
  namespace :delete do
    desc 'Delete all instances disable in database and janus'
    task unless_instance: :environment do
      tags = '[RubyRabbitmqJanus][rrj:delete:unless_instance] '
      timelaps = Time.now.utc

      Rails.logger.info "#{tags}Delete unless instance(s)"

      RubyRabbitmqJanus::Models::JanusInstance.find_by(enable: false).delete_all

      Rails.logger.info "#{tags}Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
