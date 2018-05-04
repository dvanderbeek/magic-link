module Magic
  module Link
    class Railtie < ::Rails::Railtie
      config.to_prepare do
        ::ApplicationController.send(:include, Magic::Link::ControllerExtensions)
        ::ApplicationController.send(:helper, Magic::Link::ApplicationHelper)
      end
    end
  end
end
