module Magic
  module Link
    class MagicLinksController < ApplicationController
      before_action :check_user, only: :new

      def new
        @magic_link = MagicLink.new
      end

      def create
        @magic_link = MagicLink.new(permitted_params)
        @magic_link.send_login_instructions
        redirect_to main_app.root_path, notice: "Check your email for a sign in link!"
      end

      private

        def check_user
          if send("#{Magic::Link.user_class.name.downcase}_signed_in?")
            redirect_to main_app.root_path, notice: "You are already signed in"
          end
        end

        def permitted_params
          params.fetch(:magic_link, {}).permit(:email)
        end
    end
  end
end
