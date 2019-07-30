# frozen_string_literal: true

# Load environment variables for execute correctly `Binary` class

ENVIRONMENT = ENV['RAILS_ENV']
ORM = ENV['ORM']
LISTENER_PATH = ENV['LISTENER_PATH']
PROGRAM = ENV['PROGRAM_NAME']

@verbose = false
@logger_class = true
