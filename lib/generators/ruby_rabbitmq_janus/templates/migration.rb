# frozen_string_literal: true

class CreateRubyRabbitmqJanusTables < ActiveRecord::Migration
  def change
    create_table :janus_instances do |t|
      t.integer :instance
      t.integer :session, limit: 8
      t.boolean :enable
    end
  end
end
