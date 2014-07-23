require 'roar/representer/json/hal'
require 'roar/decorator'

module RewindBBS
  module Model
    class Post < BaseModel
      include Mongoid::Document
      store_in collection: 'posts'

      field :subject, type: String
      field :content, type: String
    end

    class PostRepresenter < Roar::Decorator
      include Roar::Representer::JSON::HAL
      property :subject
      property :content
    end

  end
end
