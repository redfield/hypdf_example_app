HypdfExampleApp::Application.routes.draw do
  get "pdf" => 'pdf#index'
  post "pdf" => 'pdf#create'

  post 'async_pdf' => 'pdf#async_pdf'

  root :to => 'pdf#index'
end
