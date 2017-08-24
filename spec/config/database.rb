# frozen_string_literal: true

def load_active_record
  # Configure active record
  active_record = YAML::load(File.open('./spec/config/database.yml'))

  # Connect to database
  ActiveRecord::Base.establish_connection(active_record)
  unless ActiveRecord::Base.connection.table_exists? 'janus_instances'
    ActiveRecord::Base.connection.create_table(:janus_instances) do |table|
      table.integer :instance
      table.integer :session, limit: 8
      table.boolean :enable
      table.integer :thread, limit: 8
    end
  end
end

def load_mongo
  # DatabaseCleaner[:mongoid, { connection: :test }]
  Mongoid.load!('./spec/config/mongoid.yml', :test)
end

def after_load_database
  DatabaseCleaner.clean
  create_janus_instances
end
