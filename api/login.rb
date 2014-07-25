module RewindBBS
  module Resource
    class Login < Grape::API
      include View
      include BaseAPI

      desc 'login'
      params do
        optional :id, type: String, desc: 'User ID'
        optional :username, type: String, desc: 'User name'
        requires :password, type: String, desc: 'Password'
        exactly_one_of :id, :username
      end
      post :login do
        authenticate!
        current_user.extend UserRepresenter
      end

      desc 'if login failed'
      post :unauthenticated do
        respond_error 401, 'Login failed!'
      end
    end
  end
end
