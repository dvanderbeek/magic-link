module Magic
  module Link
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
  end
end
