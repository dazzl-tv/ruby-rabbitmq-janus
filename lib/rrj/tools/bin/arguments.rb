# frozen_string_literal: true

# Arguments
#
# --log <path>

def arg_log(path, class_name)
  @logger_default = false
  @logger_class = class_name
  @logger_path = "#{Dir.pwd}/#{path}"
end

ARGV.each_with_index do |argument, position|
  case argument
  when '--log'
    arg_log(ARGV[position + 1],
            ARGV[position + 2])
  else
    next
  end
end
