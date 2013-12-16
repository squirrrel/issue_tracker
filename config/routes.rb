IssueTracker::Application.routes.draw do
  
  	devise_for :engineers, path: '/issue_manager', path_names: { sign_in: 'signin', sign_out: 'signout', 
                        sign_up: 'registration', password: 'password', edit: 'registration/edit' }

    root to: 'engineer_interfaces#index'
	resources :customer_interfaces, path: 'client/issue_ticket', only: ['new','create', 'show', 'edit', 'update'] 
	resources :engineer_interfaces, path: '/issue_manager', only: ['index', 'show', 'edit', 'update'] do
		get 'load_views', on: :collection
	end 
end
