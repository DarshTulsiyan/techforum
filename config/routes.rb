Rails.application.routes.draw do
  resources :users

  resources :posts do
    resources :comments, only: [:create]
    member do
      post :upvote
    end
  end

  root "posts#index"
end