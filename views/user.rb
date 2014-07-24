require 'roar/representer/json'

module RewindBBS
  module View
    module UserRepresenter
      include Roar::Representer::JSON

      property :id
      property :name
    end

    module UsersRepresenter
      include Roar::Representer::JSON

      collection :all, as: :users, extend: UserRepresenter, embedded: true
    end
  end
end
