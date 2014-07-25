require 'roar/representer/json'

module RewindBBS
  module View
    module UserRepresenter
      include Roar::Representer::JSON

      property :id
      property :name
      property :email
      property :avatar_url
      property :bio
      property :title
    end

    module UsersRepresenter
      include Roar::Representer::JSON
      include ListRepresenter

      collection :all, as: :users, extend: UserRepresenter, embedded: true
    end
  end
end
