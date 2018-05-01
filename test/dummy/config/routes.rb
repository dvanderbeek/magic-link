Rails.application.routes.draw do
  mount Magic::Link::Engine => "/magic-link"
end
