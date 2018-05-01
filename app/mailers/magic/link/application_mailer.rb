module Magic
  module Link
    class ApplicationMailer < ::ApplicationMailer
      default from: Magic::Link.email_from
      layout 'mailer'
    end
  end
end
