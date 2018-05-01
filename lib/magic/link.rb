require "magic/link/engine"

module Magic
  module Link
    mattr_accessor :user_class
    @@user_class = "User"

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
