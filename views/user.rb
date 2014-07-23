require 'roar/representer/json/hal'
require 'representable/json/collection'

module RewindBBS
  module View
    module UserRepresenter
      include Roar::Representer::JSON::HAL

      property :id
      property :name
    end

    module UsersRepresenter
      include Representable::JSON::Collection
      items extend: UserRepresenter
    end
  end
end
