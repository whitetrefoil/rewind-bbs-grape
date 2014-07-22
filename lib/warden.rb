require 'warden'

module RewindBBS
  class Service
    use Warden::Manager do |config|
      config.default_strategies :api
      config.failure_app = self
    end

    Warden::Strategies.add :api do
      def valid?
        params['username'] || params['password']
      end

      def authenticate!
        auth_result = User.authenticate! params['username'], params['password']
        puts auth_result
        if auth_result.nil?
          fail!
        else
          success! auth_result
        end
      end
    end

  end
end
