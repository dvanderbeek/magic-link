require "magic/link/engine"

module Magic
  module Link
    mattr_accessor :user_class
    @@user_class = "User"

    class << self
      def configure
        yield self
      end

      def user_class
        @@user_class.constantize
      end
    end

    module ControllerExtensions
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def authenticate_user_from_token!
          email = params[:email].presence
          user  = email && Magic::Link.user_class.find_by(email: email)

          if user && Devise.secure_compare(user.sign_in_token, Devise.token_generator.digest(Magic::Link.user_class, :sign_in_token, params[:sign_in_token]))
            user.update_columns(sign_in_token: nil, sign_in_token_sent_at: nil)
            sign_in user
          end
        end
      end
    end

    class Railtie < ::Rails::Railtie
      config.to_prepare do
        ::ApplicationController.send(:include, Magic::Link::ControllerExtensions)
      end
    end
  end
end
