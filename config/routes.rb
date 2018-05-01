Magic::Link::Engine.routes.draw do
  resources :magic_links, only: [:new, :create]
end
