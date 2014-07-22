module RewindBBS
  module Resource

  end

  class BaseAPI < Grape::API
  end
end

require_relative 'posts'
require_relative 'users'
