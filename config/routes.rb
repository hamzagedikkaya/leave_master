# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  devise_scope :user do
    get "two_factor_setup", to: "users/sessions#two_factor_setup", as: :two_factor_setup
    post "verify_two_factor", to: "users/sessions#verify_two_factor", as: :verify_two_factor
  end

  root "main#home"

  resources :roles
  resources :teams

  post "update_locale", to: "application#update_locale", as: :update_locale

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
