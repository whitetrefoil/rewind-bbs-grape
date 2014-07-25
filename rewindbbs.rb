require 'grape'
require 'mongoid'

Mongoid.load! './config/mongoid.yml'

require_relative 'models/model'
require_relative 'views/view'
require_relative 'lib/warden'
require_relative 'api/api'

module RewindBBS
  class Service < Grape::API
    mount RewindBBS::Resource::Users
    mount RewindBBS::Resource::Login
  end
end

