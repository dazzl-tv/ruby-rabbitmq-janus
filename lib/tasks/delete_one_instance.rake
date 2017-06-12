# frozen_string_literal: true

namespace :rrj do
  namespace :delete do
    desc 'Delete one instance in database and janus'
    task :one_instance, [:instance, :session] => :environment do |_task, args|
      tags = '[RubyRabbitmqJanus][rrj:delete:one_instance] '
      timelaps = Time.now.utc

      Rails.logger.info "#{tags}Delete instance #{args[:instance]} " \
                        "with session #{args[:session]}"

      janus_instance = RubyRabbitmqJanus::Models::JanusInstance\
        .find_by_session(args[:session])

      janus_instance.destroy if janus_instance

      Rails.logger.info  "#{tags}Executed in #{Time.now.utc - timelaps} ms"
    end
  end
end
