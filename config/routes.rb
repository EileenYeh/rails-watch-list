Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get "bookmarks", to: "bookmarks#index", as: :bookmarks

  # get "bookmarks/new", to: "bookmarks#new"
  # post "bookmarks", to: "bookmarks#create"

  # get "bookmarks/:id/edit", to: "bookmarks#edit", as: :edit_bookmark

  # get "bookmarks/:id", to: "bookmarks#show", as: :bookmark

  # patch "bookmarks/:id", to: "bookmarks#update"

  # delete "bookmarks/:id", to: "bookmarks#destroy"

  # ou en plus simple rest:
  # resources :bookmarks, only: [:index, :show, :new, :create]

  # mais on doit faire nest
  resources :lists do # car lists est la table parent
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end
