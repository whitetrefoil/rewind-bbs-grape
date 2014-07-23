require 'roar/representer/json/hal'
require 'roar/representer/json'
require 'roar/decorator'
require 'active_support/concern'

module RewindBBS
  module Representer
    extend ActiveSupport::Concern

    included do
      decorator = Module.new do
        json = Class.new(Roar::Decorator) do
          include Roar::Representer::JSON
        end
        self.const_set :JSON, json

        hal = Class.new(Roar::Decorator) do
          include Roar::Representer::JSON::HAL
        end
        self.const_set :HAL, hal

        class << self
          def method_missing(name, *args, &block)
            hit = false
            if self::HAL.respond_to? name
              self::HAL.send name, *args, &block
              hit = true
            end
            if self::JSON.respond_to? name
              self::JSON.send name, *args, &block
              hit = true
            end
            raise NameError, "undefined method `#{name.to_s}' for neither JSON nor HAL representer" unless hit
          end
        end
      end
      self.const_set :Decorator, decorator
    end

    def to_json(options={})
      fix_id self.class::Decorator::JSON.new(self).to_json(options)

    end

    def to_hal(options={})
      fix_id self.class::Decorator::HAL.new(self).to_json(options)
    end

    alias_method :to_hal_json, :to_hal

    protected

    def fix_id(json)
      json['id'] = json.delete('_id') if json['id'].nil?
      unless json['id'].is_a? String
        json['id'] = json['id']['$oid']
      end
      json
    end

    module ClassMethods
      def exports(&block)
        block.call self::Decorator
      end
    end
  end
end
