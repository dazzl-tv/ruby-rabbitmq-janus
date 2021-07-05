# frozen_string_literal: true

# :reek:DuplicateMethodCall

def load_active_record
  # Configure active record
  active_record = YAML.safe_load(File.open('./spec/config/database.yml'))

  # Connect to database
  ActiveRecord::Base.establish_connection(active_record)
  migrate unless ActiveRecord::Base.connection.table_exists? 'janus_instances'
end

# :reek:UtilityFunction
def migrate
  ActiveRecord::Base.connection.create_table(:janus_instances) do |table|
    table.integer :session, limit: 8
    table.boolean :enable
    table.string :name
  end
end

# :reek:UtilityFunction
def load_mongo
  Mongoid.load!('./spec/config/mongoid.yml', :test)
end

# :reek:UtilityFunction
def clean_db_and_queues
  DatabaseCleaner.clean

  rb = RubyRabbitmqJanus::Rabbit::Connect.new
  rb.start

  channel = rb.channel

  %w[from-janus from-janus-admin].each do |queue_name|
    queue = channel.queue(queue_name, auto_delete: false)
    queue.purge
  end

  rb.close
end
