module RewindBBS
  module Resource
    class Users < Grape::API
      include View

      content_type :json, 'application/json'
      content_type :hal_json, 'application/hal+json'
      formatter :hal_json, lambda { |obj, env| obj.to_json }


      desc 'List all users'
      get do
        users = Model::User.all
        users.extend UsersRepresenter
      end

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
        user.extend UserRepresenter
      end
    end
  end
end
