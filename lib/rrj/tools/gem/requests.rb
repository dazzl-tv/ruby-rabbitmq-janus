# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Load files json in `config/request/**/*`.
    #
    # This file is used for sending a request to Janus
    #
    # @!attribute [r] requests
    #   @return [Hash] It's a hash with name and path to request.
    #
    # @see file:/config/requests.md For more information to type requests used.
    class Requests
      include Singleton

      attr_reader :requests

      # Define folder to request
      PATH_REQUEST = 'config/requests/'

      # Load all requests in folder
      def initialize
        @requests = {}
        Tools::Log.instance.info "Loading all requests in : #{PATH_REQUEST}"
        Dir[File.join(PATH_REQUEST, '*')].count { |file| each_files(file) }
      rescue
        raise Errors::Tools::Request::Initializer
      end

      private

      def each_folder(subfolder)
        Dir[File.join(PATH_REQUEST + subfolder, '*')].count do |file|
          if File.file?(file)
            read_folder(subfolder.gsub('/', '::') + '::', file)
          elsif File.directory?(file)
            each_folder(subfolder + '/' + File.basename(file))
          end
        end
      end

      def read_file(file)
        @requests[File.basename(file, '.json').to_s] = File.path(file)
      end

      def read_folder(folder, file)
        @requests[folder + File.basename(file, '.json').to_s] = File.path(file)
      end

      def each_files(file)
        if File.file?(file)
          read_file(file)
        elsif File.directory?(file)
          each_folder(File.basename(file))
        end
      end
    end
  end
end
