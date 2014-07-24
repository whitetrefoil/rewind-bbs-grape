require 'mongoid/criteria'
require 'bson/object_id'

class Mongoid::Criteria
  def pre_page
    @pre_page
  end
  def pre_page=(n)
    @pre_page = n
  end
end

class BSON::ObjectId
  def as_json(options = nil)
    to_s
  end
end

module RewindBBS
  class BaseModel
  end
end

require_relative 'user'
