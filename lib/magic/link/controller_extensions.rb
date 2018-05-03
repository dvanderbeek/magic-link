module Magic
  module Link
    module ControllerExtensions
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def authenticate_user_from_token!
          email = params[:email].presence
          token = params[:sign_in_token].presence
          user  = email && token && Magic::Link.user_class.find_by(email: email)

          if user && token_matches?(user) && token_not_expired?(user)
            flash[:notice] = "You have signed in successfully"
            user.update_columns(sign_in_token: nil, sign_in_token_sent_at: nil)
            sign_in user
          elsif email && token
            flash[:alert] = "Your sign in token has already been used or is expired"
            redirect_to main_app.root_path
          end
        end

        def token_matches?(user)
          Devise.secure_compare(
            user.sign_in_token,
            Devise.token_generator.digest(Magic::Link.user_class, :sign_in_token, params[:sign_in_token])
          )
        end

        def token_not_expired?(user)
          user.sign_in_token_sent_at >= Magic::Link.token_expiration_hours.hours.ago
        end
      end
    end
  end
end
