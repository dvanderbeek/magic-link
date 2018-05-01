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

          if user && token_matches?(user) && token_not_expired?
            user.update_columns(sign_in_token: nil, sign_in_token_sent_at: nil)
            sign_in user
          end
        end

        def token_mathces?(user)
          Devise.secure_compare(
            user.sign_in_token,
            Devise.token_generator.digest(Magic::Link.user_class, :sign_in_token, params[:sign_in_token])
          )
        end

        def token_not_expired?
          user.sign_in_token_sent_at >= 6.seconds.ago
        end
      end
    end
  end
end
