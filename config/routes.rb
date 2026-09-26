Rails.application.routes.draw do
  resources :users

  resources :comments, only: %i[index show new edit update destroy]

  resources :posts do
    resources :comments, only: [:create]

    member do
      post :upvote
    end
  end

  root "home#index"
end
