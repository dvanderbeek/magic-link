Magic::Link::Engine.routes.draw do
  resources :magic_links, only: [:new, :create]
  get "/magic_links/authenticate", to: "magic_links#authenticate", as: :authenticate
end
