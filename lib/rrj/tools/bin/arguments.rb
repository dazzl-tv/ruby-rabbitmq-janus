# frozen_string_literal: true

# Arguments
#
# --verbose
# --log <path>

def arg_log(path, class_name)
  @logger_default = false
  @logger_class = class_name
  @logger_path = "#{Dir.pwd}/#{path}"
end

def arg_verbose
  @verbose = true
end

ARGV.each_with_index do |argument, position|
  case argument
  when '--log'
    arg_log(ARGV[position + 1],
            ARGV[position + 2])
  when --'verbose'
    arg_verbose
  else
    next
  end
end
