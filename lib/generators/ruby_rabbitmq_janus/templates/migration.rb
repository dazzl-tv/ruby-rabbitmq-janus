# frozen_string_literal: true

class CreateRubyRabbitmqJanusTables < ActiveRecord::Migration
  def change
    create_table :janus_instances do |t|
      t.integer :instance
      t.integer :session
      t.boolean :enable
    end
  end
end
