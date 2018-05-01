module Magic
  module Link
    class MagicLink
      include ActiveModel::Model
      attr_accessor :email, :token

      def send_login_instructions
      end

      private

        def customer
          @customer ||= Customer.find_by(email: email.downcase)
        end

        def send_reset_password_instructions_notification(token)
          puts "SENDING LOGIN INSTRUCTIONS WITH TOKEN #{token}"
        end

        def set_sign_in_token
          if customer && customer.sign_in_token.blank? || customer.sign_in_token_sent_at < 6.hours.ago
            raw, enc = Devise.token_generator.generate(Customer, :sign_in_token)
            customer.sign_in_token = enc
            customer.sign_in_token_sent_at = Time.current
            customer.save(validate: false)
            raw
          end
        end
    end
  end
end


class MagicLink
  include ActiveModel::Model

  attr_accessor :email, :token

  def send_login_instructions
    token = set_sign_in_token
    send_reset_password_instructions_notification(token) if token
    token
  end

  private
    def customer
      @customer ||= Customer.find_by(email: email.downcase)
    end

    def send_reset_password_instructions_notification(token)
      puts "SENDING LOGIN INSTRUCTIONS WITH TOKEN #{token}"
    end

    def set_sign_in_token

    end
end
