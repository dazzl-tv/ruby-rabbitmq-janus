# frozen_string_literal: true
# NOTE: DELETE !!
# Helpers method for admin requester
# Use this methods before execute block 'it'

def help_admin_prepare
  @opt_instance = instance
  @opt_transaction = {}
  @transaction = nil
end

def help_admin_create_session
  @gateway.session_endpoint_public(@opt_instance) do |transaction|
    session = transaction.publish_message('base::create', @opt_transaction).session

    @opt_transaction['session_id'] = session
    @opt_instance.merge!(@opt_transaction)
  end
end

def help_admin_create_handler
  @gateway.session_endpoint_public(@opt_instance) do |transaction|
    handler = transaction.publish_message('base::attach', @opt_transaction).sender
    @opt_transaction['handle_id'] = handler
    @opt_instance.merge!(@opt_transaction)
  end
end

def help_admin_request_before(type_before, admin_opt = {})
  @opt_transaction.merge!(admin_opt)

  @gateway.admin_endpoint(@opt_instance) do |transaction|
    transaction.publish_message(type_before, @opt_transaction)
  end
end

def help_admin_request_tested(admin_opt = {})
  @opt_transaction.merge!(admin_opt)

  @gateway.admin_endpoint(@opt_instance) do |transaction|
    @transaction = transaction.publish_message(type, @opt_transaction)
  end
end
