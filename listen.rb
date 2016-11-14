#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby_rabbitmq_janus'

@t = RubyRabbitmqJanus::RRJ.new
@events = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance

# :reek:NilCheck and :reek:TooManyStatements
def case_event(data, jsep)
  puts "REASON : Event : #{data.class} -- #{data}"
  case data['videocontrol']
  when 'joined'
    puts 'Joined request ...'
    @t.handle_message_simple('channel::offer', jsep)
  when 'selected' then puts 'Selected request ...'
  when 'unselected' then puts 'Unselected request ...'
  when 'left' then puts 'Left request ...'
  end
  update_jsep(jsep) unless jsep.nil?
end

def update_jsep(jsep)
  puts "JSEP : #{jsep}"
end

def case_hangup
  puts 'REASON : Hangup'
  Thread.current.stop
end

def case_stop
  puts 'REASON : Stop'
  Thread.current.stop
end

def case_error
  puts 'REASON : Error ...'
end

puts '## Start listen Block'
@events.listen do |reason, data, jsep|
  case reason
  when 'event' then case_event(data, jsep)
  when 'hangup' then case_hangup
  when 'stop' then case_stop
  when 'error' then case_error
  else
    puts 'REASON default'
  end
end
puts '## End listen block'

puts 'apps running'
loop do
end
