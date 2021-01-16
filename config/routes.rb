# frozen_string_literal: true

Rails.application.routes.draw do
  get '/:search', to: 'homepage#search'
  get '/subject/:id', to: 'subject#show', as: :subject

  get '/coi/:id', to: 'charts#coi', as: :coi_charts
  get '/coi_sanction/:id', to: 'charts#coi_sanctions', as: :coi_sanctions_charts

  root to: 'homepage#index'
end
