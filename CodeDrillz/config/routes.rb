Rails.application.routes.draw do

  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  # devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  # devise_for :users, ActiveAdmin::Devise.config
  # , ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  resources :groups do
    resources :drills
  end

  resources :categories
  get "/users/profile" => "users#show", as: :profile
  resources :users
  # devise_for :users, controllers: {
          # sessions: 'users/sessions'
        # }

  # get "users/create" => "users#create", as: :user_sign_up

  post "/homes/:drill_id/add" => "homes#create", as: :add_drill

  resources :homes
  resources :badges
  root "homes#welcome"
  get "/welcome" => "homes#welcome", as: :welcome


end
# every single file in views/users is junk & should eventually be deleted.
# everything you'd think to be in that folder is actually in views/devise
