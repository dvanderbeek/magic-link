module Magic
  module Link
    class ApplicationController < ::ApplicationController
      protect_from_forgery with: :exception
    end
  end
end
