# frozen_string_literal: true

# Load environment variables for execute correctly `Binary` class

def blank?(value)
  value.eql?('') || value.nil?
end

def check_variable(name)
  blank?(ENV[name]) ? raise(NameError) : ENV[name]
end

ENVIRONMENT = check_variable('RAILS_ENV')
ORM = check_variable('ORM')
LISTENER_PATH = check_variable('LISTENER_PATH')
PROGRAM = check_variable('PROGRAM_NAME')

@verbose = false
@logger_class = true
