# frozen_string_literal: true
# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # Define a super class for all errors in RRJ Class
    class RRJ < RRJError
      # Define a message error and level
      # @param [String] message Text returning in raise
      # @param [Symbol] level Level to message in log
      def initalize(message, level)
        super "[RRJ] #{message}", level
      end
    end

    # Define an exception if gem dont initialize correctly
    class InstanciateGemFailed < RRJ
      # Initialize a error for instanciate class. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Gem is not instanciate correctly : #{message}", :fatal
      end
    end

    # Define an error if method message_post given an exception
    class TransactionSessionFailed < RRJ
      # Initialize a error for message posting. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Transaction SESSION failed : #{message}", :fatal
      end
    end

    # Define a error if method transaction given an exception
    class TransactionMessageFailed < RRJ
      # Initialize a error for transaction failed. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Message in a transaction HANDLE failed : #{message}", :fatal
      end
    end

    # Define a error if method start_handle given an exception
    class TransactionHandleFailed < RRJ
      # Initialize a error for transaction with a handle. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Transaction HANDLE failed : #{message}", :fatal
      end
    end

    # define a error for Admin Transaction
    class TransactionAdminFailed < RRJ
      # Initialize a error for transaction admin
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Transaction ADMIN failed : #{message}", :fatal
      end
    end
  end
end
