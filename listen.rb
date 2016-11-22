#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby_rabbitmq_janus'

@t = RubyRabbitmqJanus::RRJ.new
@e = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance

def case_event(response)
  puts "REASON : Event : #{response.to_hash}"
end

def case_hangup(data)
  puts "REASON : Hangup : #{data}"
end

def case_error(data)
  puts "REASON : Error : #{data}"
end

def case_stop
  puts 'REASON : Stop'
  Thread.current.stop
end

events = lambda do |reason, response|
  puts "Execute block code with reason : #{reason}"
  case reason
  when 'event' then case_event(response)
  when 'hangup' then case_hangup(response)
  when 'error' then case_error(response)
  when 'stop' then case_stop
  else
    puts 'REASON default'
  end
  puts " --\n\r"
end

puts '## Start listen Block'
@e.run(&events)
puts '## End listen block'

puts '## APPS RUNNING'
loop do
end
