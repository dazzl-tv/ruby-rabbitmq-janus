# frozen_string_literal: true

require 'rrj/init'

# Define tools for this gems
require 'rrj/tools/log'
require 'rrj/tools/config'
require 'rrj/tools/requests'
require 'rrj/tools/type_data'
require 'rrj/tools/replaces'

# Define actions with rabbitmq
require 'rrj/rabbit/rabbitmq'

# Define actions with janus
require 'rrj/janus/janus'
require 'rrj/janus/keepalive'
require 'rrj/janus/message/message'
require 'rrj/janus/message/message_sync'
require 'rrj/janus/message/message_async'
require 'rrj/janus/response/response'
require 'rrj/janus/response/response_error'

# Define action with api

# Define errors in gems
require 'rrj/errors/error'
require 'rrj/errors/janus'
require 'rrj/errors/config'
require 'rrj/errors/rabbitmq'
require 'rrj/errors/request'
