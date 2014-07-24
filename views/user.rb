require 'roar/representer/json/hal'

module RewindBBS
  module View
    module UserRepresenter
      include Roar::Representer::JSON::HAL

      property :id
      property :name
    end

    module UsersRepresenter
      include Roar::Representer::JSON::HAL

      collection :all, as: :users, extend: UserRepresenter, embedded: true
    end
  end
end
