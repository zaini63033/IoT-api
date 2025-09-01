Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Hello route
  get "hello/:name", to: "greetings#hello"

  # Defines the root path route ("/")
  # root "posts#index"

  # Create Reading Route
  post "readings", to: "readings#create"


  get "devices/:device_id/readings", to: "readings#get_device_readings"
end
