# frozen_string_literal: true

# Execute this code when janus return an events in admin queue
class AdminActions
  def initialize
    puts '[admin] Initialize listener AdminActions'
  end

  # Default method using for sending a block of code
  def actions
    response = nil

    lambda do |_reason, data|
      puts "[admin] Execute block code with reason : #{reason}"
      case_events(data.to_hash)
    end

    response
  end

  private

  def case_events(data)
    puts "[admin] Event : #{data}"
  end
end
