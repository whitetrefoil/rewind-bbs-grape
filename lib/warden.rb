require 'warden'

module RewindBBS
  class Service < Grape::API
    use Warden::Manager do |config|
      config.default_strategies :api
      config.failure_app = self
    end

    use Rack::Session::Cookie, :secret => SecureRandom.uuid

    Warden::Manager.serialize_into_session { |user| user.id }
    Warden::Manager.serialize_from_session { |id| Model::User.find(id) }

    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    Warden::Strategies.add :api do
      def valid?
        (params['id'] or params['username']) and params['password']
      end

      def authenticate!
        auth_result = Model::User.authenticate id: params['id'],
                                         name: params['username'],
                                         pass: params['password']
        if auth_result.nil?
          fail!
        else
          success! auth_result
        end
      end
    end

    helpers do
      def warden
        unless @warden
          @warden = env['warden']
          @warden.request.params.merge! params
        end
        @warden
      end

      def authenticate!
        warden.authenticate!
      end

      def authenticate
        warden.authenticate
      end

      def current_user
        @current_user ||= authenticate
      end

      def logout!
        warden.logout
      end
    end

  end
end
