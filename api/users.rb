module RewindBBS
  module Resource
    class Users < Grape::API
      include View
      include BaseAPI

      default_format :json
      content_type :json, 'application/json'
      content_type :hal_json, 'application/hal+json'
      formatter :hal_json, lambda { |obj, env| obj.to_json }

      resource :users do
        desc 'List all users'
        get do
          Model::User.extend UsersRepresenter
        end

        desc 'Get one user'
        params do
          requires :id, type: String, desc: 'User ID'
        end
        route_param :id do
          get do
            user = Model::User.find params[:id] rescue respond_error 404, 'No such user!'
            user.extend UserRepresenter
          end
        end

        desc 'Create a new user'
        params do
          requires :name,     type: String, desc: 'Username'
          requires :password, type: String, desc: 'Password'
        end
        post do
          begin
            user = Model::User.create!(
                name:     params[:name],
                password: params[:password]
            )
          rescue Mongoid::Errors::Validations => e
            respond_error 409, e.as_json['summary']
          end
          user.extend UserRepresenter
        end

        desc 'Modify a existing user'
        params do
          requires :id, type: String, desc: 'User ID'
          requires :name, type: String, desc: 'User name'
        end
        route_param :id do
          put do
            user = Model::User.find params[:id] rescue respond_error 404, 'No such user!'
            user.update_attributes name: params[:name]
            user.save
            user.extend UserRepresenter
          end
        end

        desc 'Delete a existing user'
        params do
          requires :id, type: String, desc: 'User ID'
        end
        route_param :id do
          delete do
            user = Model::User.find params[:id] rescue respond_error 404, 'No such user!'
            user.destroy
            user.extend UserRepresenter
          end
        end
      end
    end
  end
end
