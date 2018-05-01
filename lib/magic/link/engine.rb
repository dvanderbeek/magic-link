module Magic
  module Link
    class Engine < ::Rails::Engine
      isolate_namespace Magic::Link
    end
  end
end
