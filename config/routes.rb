# frozen_string_literal: true

Rails.application.routes.draw do
  get '/:search', to: 'homepage#search'
  get '/subject/:id', to: 'subject#show', as: :subject

  root to: 'homepage#index'
end
