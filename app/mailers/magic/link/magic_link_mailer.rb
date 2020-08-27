module Magic::Link
  class MagicLinkMailer < ApplicationMailer
    def send_magic_link(email, token)
      @email = email
      @token = token
      mail(to: email, subject: I18n.t('magic_links.mailer.magic_link.subject'))
    end
  end
end
