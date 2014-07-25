module RewindBBS
  module Resource
    module BaseAPI
      def self.included(base)
        base.class_eval do
          default_format :json

          helpers do
            def respond_error(code, msg)
              error!({ code: code, message: msg }, code)
            end
          end
        end
      end
    end
  end
end

require_relative 'users'
require_relative 'login'
