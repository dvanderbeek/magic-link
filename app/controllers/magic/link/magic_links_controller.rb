module Magic
  module Link
    class MagicLinksController < ::ApplicationController
      skip_before_action :authenticate_user!, :raise => false
      before_action :check_user, only: :new

      def new
        @magic_link = MagicLink.new
      end

      def create
        @magic_link = MagicLink.new(permitted_params)
        @magic_link.send_login_instructions
        redirect_to main_app.root_path, notice: I18n.t('magic_links.check_email')
      end

      def authenticate
        email = params[:email].presence
        token = params[:sign_in_token].presence
        user  = email && token && Magic::Link.user_class.find_by(email: email)

        # TODO: Handle a different user trying to sign in
        if token && send("#{Magic::Link.user_class.name.underscore}_signed_in?")
          flash[:alert] = I18n.t('magic_links.already_signed_in')
          redirect_to main_app.send(Magic::Link.after_sign_in_path)
        elsif user && token_matches?(user) && token_not_expired?(user)
          flash[:notice] = I18n.t('magic_links.signed_in')
          user.update_columns(sign_in_token: nil, sign_in_token_sent_at: nil)
          sign_in user
          redirect_to main_app.send(Magic::Link.after_sign_in_path)
        elsif email && token
          flash[:alert] = I18n.t('magic_links.token_invalid')
          redirect_to magic_link.new_magic_link_path
        end
      end

      private

        def check_user
          if send("#{Magic::Link.user_class.name.underscore}_signed_in?")
            redirect_to main_app.root_path, notice: I18n.t('magic_links.already_signed_in')
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

        def permitted_params
          params.fetch(:magic_link, {}).permit(:email)
        end
    end
  end
end
