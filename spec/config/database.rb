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
