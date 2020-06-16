Rails.application.routes.draw do
  devise_for :users
  resources :feeds do
    resources :feed_entries
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'feeds#index'
end
