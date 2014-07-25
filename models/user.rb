require 'bcrypt'

module RewindBBS
  module Model
    class User
      include Mongoid::Document
      include Mongoid::Timestamps
      include BCrypt
      include Paginatable

      store_in collection: 'users'

      before_save :encrypt_password

      field :name,     type: String
      field :password, type: String

      validates :name, uniqueness: true

      def authenticate(pass)
        check_password pass
      end

      class << self
        def authenticate(id: nil, name: nil, pass: nil)
          user = nil
          user = self.find(id) unless id.nil?
          user ||= self.where(name: name).first unless name.nil?
          if user and user.authenticate(pass)
            user
          else
            nil
          end
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
