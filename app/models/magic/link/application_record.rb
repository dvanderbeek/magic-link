module Magic
  module Link
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
