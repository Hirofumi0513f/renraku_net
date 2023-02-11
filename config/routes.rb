Rails.application.routes.draw do
  namespace :public do
    get 'staffs/index'
    get 'staffs/show'
    get 'staffs/edit'
    get 'staffs/update'
    get 'staffs/search'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'actives/update'
  end
  namespace :admin do
    get 'divisions/index'
    get 'divisions/create'
    get 'divisions/edit'
    get 'divisions/update'
  end
  namespace :admin do
    get 'departments/index'
    get 'departments/create'
    get 'departments/edit'
    get 'departments/update'
  end
  namespace :admin do
    get 'staffs/index'
    get 'staffs/show'
    get 'staffs/edit'
    get 'staffs/search'
  end
  namespace :admin do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admins
  devise_for :staffs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
