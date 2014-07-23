require 'bcrypt'

module RewindBBS
  module Model

    class User < BaseModel
      include Mongoid::Document
      include Mongoid::Timestamps
      include BCrypt

      store_in collection: 'users'

      before_save :encrypt_password

      field :name,     type: String
      field :password, type: String

      def authenticate(pass)
        check_password pass
      end

      def self.authenticate(name, pass)
        user = self.where(name: name).first
        if !user.nil? and user.authenticate(pass)
          user
        else
          nil
        end
      end

      protected

      def check_password(password)
        Password.new(self[:password]) == password
      end

      def encrypt_password
        self[:password] = Password.create self[:password]
      end

    end
  end
end
