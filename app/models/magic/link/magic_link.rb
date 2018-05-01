module Magic
  module Link
    class MagicLink
      include ActiveModel::Model
      attr_accessor :email

      def send_login_instructions
        token = set_sign_in_token
        send_reset_password_instructions_notification(token) if token
        token
      end

      private

        def user
          @user ||= Magic::Link.user_class.find_by(email: email.downcase)
        end

        def send_reset_password_instructions_notification(token)
          MagicLinkMailer.send_magic_link(email, token).deliver_later
        end

        def set_sign_in_token
          if user && (user.sign_in_token.blank? || user.sign_in_token_sent_at < 6.hours.ago)
            raw, enc = Devise.token_generator.generate(Magic::Link.user_class, :sign_in_token)
            user.sign_in_token = enc
            user.sign_in_token_sent_at = Time.current
            user.save(validate: false)
            raw
          end
        end
    end
  end
end
