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

      property :count, as: :total
      property :pre_page
      property :max_page
      property :from
      property :to
      collection :all, as: :users, extend: UserRepresenter, embedded: true
    end
  end
end
