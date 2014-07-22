module RewindBBS
  module Resource
    class Users < Grape::API
      content_type :json, 'application/json'
      content_type :hal_json, 'application/hal+json'
      formatter :hal_json, lambda { |obj, env| obj.to_hal_json }

      desc 'Create a new user'
      params do
        requires :name,     type: String, desc: 'Username'
        requires :password, type: String, desc: 'Password'
      end
      post do
        user = Model::User.create(
            name:     params[:name],
            password: params[:password]
        )
      end
    end
  end
end
