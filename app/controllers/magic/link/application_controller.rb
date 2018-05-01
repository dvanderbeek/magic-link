module Magic
  module Link
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
    end
  end
end
