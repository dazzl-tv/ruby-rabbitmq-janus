# frozen_string_literal: true

# Load all tools necessary to good functionlaty to this gem
require 'rrj/init'
require 'rrj/admin'
require 'rrj/task'
require 'rrj/task_admin'
require 'rrj/rspec'

# Define tools for this gems
require 'rrj/tools/tools'

# Define actions with rabbitmq
require 'rrj/rabbit/rabbit'

# Define actions with janus
require 'rrj/janus/janus'

# Define process create on fly for manage keepalive and public queu
require 'rrj/process/concurrency'

# Define errors in gems
require 'rrj/errors/error'

require 'rrj/railtie' if defined?(Rails)
