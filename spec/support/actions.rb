# frozen_string_literal: true

# Execute this code when janus return an events in standard queue
class Actions
  def initialize
    puts 'Initialize listener Actions'
  end

  # Default method using for sending a block of code
  def actions
    response = nil

    lambda do |reason, data|
      puts "Execute block code with reason : #{reason}"
      break response = data
    end

    response
  end

  private

  def case_events(data)
    puts "Event : #{data}"
  end
end
