HyperpdfExampleApp::Application.routes.draw do
  get "pdf" => 'pdf#index'
  post "pdf" => 'pdf#create'

  root :to => 'pdf#index'
end
