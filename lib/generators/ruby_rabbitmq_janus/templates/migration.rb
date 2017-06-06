# frozen_string_literal: true

# Fields for JanusInstance model
class CreateRubyRabbitmqJanusTables < ActiveRecord::Migration[5.0]
  def change
    create_table :janus_instances do |t|
      t.integer :instance
      t.integer :session, limit: 8
      t.boolean :enable
    end
  end
end
