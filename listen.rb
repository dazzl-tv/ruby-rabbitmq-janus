#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby_rabbitmq_janus'

@t = RubyRabbitmqJanus::RRJ.new
@e = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance

# :reek:NilCheck and :reek:TooManyStatements
def case_event(data, jsep)
  puts "REASON : Event : #{data.class} -- #{data}"
  case data['videocontrol']
  when 'joined'
    puts 'Joined request ...'
    @t.handle_message_simple('channel::offer', jsep)
  end
  update_jsep(jsep) unless jsep.nil?
end

def update_jsep(jsep)
  puts "JSEP : #{jsep}"
end

def case_stop
  puts 'REASON : Stop'
  Thread.current.stop
end

events = lambda do |reason, data = nil, jsep = nil|
  puts "Execute block code with reason : #{reason}"
  case reason
  when 'event' then case_event(data, jsep)
  when 'stop' then case_stop
  else
    puts 'REASON default'
  end
end

puts '## Start listen Block'
@e.run(&events)
puts '## End listen block'

puts '## APPS RUNNING'
loop do
end
