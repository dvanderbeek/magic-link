require "magic/link/engine"
require "magic/link/controller_extensions"
require "magic/link/railtie"

module Magic
  module Link
    mattr_accessor :user_class
    @@user_class = "User"

    mattr_accessor :email_from
    @@email_from = "please-change-me@magic-link.com"

    mattr_accessor :token_expiration_hours
    @@token_expiration_hours = 6

    class << self
      def configure
        yield self
      end

      def user_class
        @@user_class.constantize
      end
    end
  end
end
