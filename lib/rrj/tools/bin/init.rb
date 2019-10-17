# frozen_string_literal: true

require 'rrj/rails' if defined?(::Rails::Engine)

Log.info 'Listen Public queue to Janus'
loop {}
