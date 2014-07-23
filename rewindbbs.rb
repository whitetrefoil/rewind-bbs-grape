require 'grape'
require 'mongoid'

Mongoid.load! './config/mongoid.yml'

require_relative 'lib/representer'
require_relative 'model/model'
require_relative 'api/api'

module RewindBBS
  class Service < Grape::API
  end
end

