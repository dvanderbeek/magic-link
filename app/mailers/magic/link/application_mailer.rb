module Magic
  module Link
    class ApplicationMailer < ActionMailer::Base
      default from: Magic::Link.email_from
      layout 'mailer'
    end
  end
end
