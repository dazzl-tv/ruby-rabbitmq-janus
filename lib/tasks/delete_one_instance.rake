# frozen_string_literal: true

namespace :rrj do
  namespace :delete do
    desc 'Delete one instance in database and janus'
    task :one_instance, [:instance, :session] => :environment do |_task, args|
      timelaps = Time.now.utc

      Rails.logger.info \
        "Delete instance #{args[:instance]} with session #{args[:session]}"

      RubyRabbitmqJanus::Models::JanusInstance\
        .find_by_session(args[:session]).destroy

      Rails.logger.info "Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
