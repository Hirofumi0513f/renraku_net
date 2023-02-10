Rails.application.routes.draw do
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
