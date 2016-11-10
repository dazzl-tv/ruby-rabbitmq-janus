#!/usr/bin/env ruby

require 'ruby_rabbitmq_janus'

t = RubyRabbitmqJanus::RRJ.new

puts "## Start listen Block"
pid = fork do
  t.listen do |reason, data, jsep|
    RubyRabbitmqJanus::Tools::Log.instance.info \
      "Test message received ... -- \n\r" \
      "Reason : #{reason.inspect} -- #{reason.class} \r\n" \
      "Data : #{data.inspect} -- data : #{data.class}\r\n" \
      "Data : #{jsep.inspect} -- data : #{jsep.class}"
    case reason
    when 'event'
      puts "REASON : #{reason}"
      case data['videocontrol']
      when 'joined'
        puts 'Joined request ...'
      end
    else
      puts "REASON default : #{reason}"
    end
  end
end
puts "## End listen Block | PID : #{pid}"

puts "apps running"
loop do
end
