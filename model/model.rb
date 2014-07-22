#require 'roar/representer/json/hal'

require 'bson/object_id'

class BSON::ObjectId
  def as_json(options = nil)
    to_s
  end
end

module RewindBBS
  class BaseModel
  end
end

require_relative 'post'
require_relative 'user'
