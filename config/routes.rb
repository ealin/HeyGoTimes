HeyGoTimes::Application.routes.draw do
  
   
  get "terms_of_service/index"

  get "privacy/index"

  get "template/index"

  get "edit_area/index"

  get "admin/index"

  get "translator/index"

  get "report/index"
  get "report/to_main_page"
  get "report/logout"

  get "area/index"

  get "setup/index"

  get "user_history/index"

  get "editor/index"
  get "editor/to_main_page"
  get "editor/logout"
  get "editor/filiter_and_sort_news"

  get "ad/index"

  get "my_ad/index"

  get "faq/index"

  resources :search do
    get 'index', :on => :collection  
    get 'do_search', :on => :collection  
    get 'to_main_page', :on => :collection  
 end

  resources :paper do
    #Ealin: 關於 :on => :collection 可參考 "http://guides.rubyonrails.org/routing.html" chapter-2.9.2
    #
    get 'index', :on => :collection  
    get 'to_main_page', :on => :collection  
    get 'filiter_today_newspaper', :on => :collection
    get 'follow', :on => :collection
    get 'login', :on => :collection
    get 'logout', :on => :collection
    get 'signup', :on => :collection
    get 'show_paper_title', :on => :collection
    get 'show_fun_buttons', :on => :collection
    get 'show_paper_content', :on => :collection
    get 'show_ad_list', :on => :collection
 end


  get "main_page/index"
  get "main_page/to_main_page"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "paper#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
