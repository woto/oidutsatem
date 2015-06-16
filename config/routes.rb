Rails.application.routes.draw do

  devise_for :users

  resources :collections

  scope :collections do
    root to: "collections#index", as: :user_root
  end

  root 'welcome#index'


end
