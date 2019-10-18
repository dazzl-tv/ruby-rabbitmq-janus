# frozen_string_literal: true

# :reek:FeatureEnvy

# Fields for JanusInstance model
class CreateRubyRabbitmqJanusTables < ActiveRecord::Migration[5.0]
  # Change for model JanusInstance
  def change
    create_table :janus_instances, id: false, force: true do |table|
      table.string :id, null: false
      table.string :name
      table.integer :session, limit: 8
      table.boolean :enable
    end
  end
end
