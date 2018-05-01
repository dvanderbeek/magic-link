module Magic::Link
  class MagicLinkMailer < ApplicationMailer
    def send_magic_link(email, token)
      @email = email
      @token = token
      mail(to: email, subject: "Your sign in link")
    end
  end
end
