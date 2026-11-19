Rails.application.routes.draw do
  root "lists#index"

  resources :lists, only: %w[ show new create ] do
    resources :bookmarks, only: %w[ new create ]
  end

  resources :bookmarks, only: %w[ destroy ]
end
