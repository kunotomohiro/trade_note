Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root :to => "users/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :static_pages

  namespace :user do
    authenticate :user do
      resource  :user_profile
      resources :trade_win_rates, only: :index
      resources :trades do
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resource  :initialisations, only: :show
    end
  end
end
