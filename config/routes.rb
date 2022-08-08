Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :plots, only: [:index]

  delete '/plant_plots/:plant_id/:plot_id', to: 'plant_plots#destroy'
end
