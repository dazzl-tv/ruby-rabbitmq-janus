# frozen_string_literal: true

class CreateRubyRabbitmqJanusTables < ActiveRecord::Migration
  def change
    create_table :janus_instance do |t|
      t.integer :instance
      t.integer :session
      t.boolean :enable
    end
  end
end

# create_table :ruby_rabbitmq_janus_tools_janus_instances do |table|
