Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get '/about',to: "public/homes#about", as: "about"

  namespace :public do
    resources :staffs, only: [:index, :show, :edit, :update] do
      collection do
        # collection：idを必要としない独自アクションの作成時に使用
        get :search_form
        get :search
      end
    end

    resources :departments, only: [:index, :create, :edit, :update]

    resources :divisions, only: [:index, :create, :edit, :update]

    resources :positions, only: [:index, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
