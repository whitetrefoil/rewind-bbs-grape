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

      validates :name, uniqueness: true

      def authenticate(pass)
        check_password pass
      end

      class << self
        def authenticate(name, pass)
          user = self.where(name: name).first
          if !user.nil? and user.authenticate(pass)
            user
          else
            nil
          end
        end

        attr_writer :pre_page
        attr_accessor :current_page

        def pre_page
          @pre_page || 10
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

        def max_page
          (Float(count) / pre_page).ceil
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
