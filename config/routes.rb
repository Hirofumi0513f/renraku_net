Rails.application.routes.draw do
    devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :staffs, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get '/about',to: "public/homes#about", as: "about"

  namespace :public do
    resources :staffs, only: [:index, :show, :edit, :update, :search]
    #社員検索用の名前付きルーティング
    get '/staffs/search', to:"staff#search", as: "search_staff"
  end

  namespace :admin do
    root to: "homes#top"
    resources :acitives, only: [:update]

    resources :staffs, only: [:index, :show, :edit]
    #社員検索用の名前付きルーティング
    get '/staffs/search', to:"staffs#search", as: "search_staff"

    resources :departments, only: [:index, :create, :edit, :update]

    resources :divisions, only: [:index, :create, :edit, :update]

    resources :positions, only: [:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
