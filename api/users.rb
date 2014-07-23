module RewindBBS
  module Resource
    class Users < Grape::API
      content_type :json, 'application/json'
      content_type :hal_json, 'application/hal+json'
      formatter :hal_json, lambda { |obj, env| obj.to_json hal: true }

      desc 'Get all users'
      get do
        Model::User.all.to_a
      end


      desc 'Create a new user'
      params do
        requires :name,     type: String, desc: 'Username'
        requires :password, type: String, desc: 'Password'
      end
      post do
        Model::User.create(
            name:     params[:name],
            password: params[:password]
        )
      end
    end
  end
end
