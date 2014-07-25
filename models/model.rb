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
  module Model
    module Paginatable

      def self.included(base)
        base.class_eval do
          class << self
            attr_writer :pre_page
            attr_accessor :current_page
          end
        end

        base.extend ClassMethods

        base.class_eval do
          class << self
            alias_method :max_page, :total_pages
          end
        end
      end

      protected

      module ClassMethods
        def pre_page
          @pre_page || 25
        end

        def from
          if current_page.nil? or count == 0 or current_page > max_page
            nil
          else
            (current_page - 1) * pre_page + 1
          end
        end

        def to
          if current_page.nil? or count == 0 or current_page > max_page
            nil
          elsif current_page == max_page
            count
          else
            current_page * pre_page
          end
        end

        def total_pages
          (Float(count) / pre_page).ceil
        end

        def paginate(page = 1)
          skip((page - 1) * pre_page).limit(pre_page)
        end
      end
    end
  end
end

require_relative 'user'
