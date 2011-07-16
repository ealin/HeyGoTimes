HeyGoTimes::Application.routes.draw do


  get "review/tw"
  get "review/spam"
  get "review/delete_news"
  get "review/delete_img_and_publish"
  get "review/publish_news"
  get "review/change_image"
  get "review/close_news"
  get "review/close_report"
  get "review/report_spam"
  get "review/delete_photo_and_close_report"


  get "api/new_news"

  get "mobile/index"

  #get "real_time_news/report"
  #get "real_time_news/to_main_page"
  #resources :real_time_news

  get "tag/get_all_tags"

  get "news/report"

  get "news/to_main_page"

  get "terms_of_service/index"

  get "privacy/index"


  get "admin/index"

  get "translator/index"


  get "feedback/index"

  #match "/setup/set_filter/:area", :to => "setup#set_filter"
  #get "setup/index"
  #get "setup/to_main_page"
  #get "setup/deactive_fb_account"
  #get "setup/connect_twitter_account"
  #get "setup/set_filter"


  get "ad/index"

  get "my_ad/index"

  get "faq/index"

  get "faq/to_main_page"
  get "faq/show_question_list"  
  get "faq/show_answer"

  get "news/like"
  post "news/like"
  post "news/report"
  post "news/comment"
  post "news/share"
  resources :news

  #resources :search do
  #  get 'index', :on => :collection
  #  get 'do_search', :on => :collection
  #  get 'to_main_page', :on => :collection
  #end

  resources :paper do
    #Ealin: 關於 :on => :collection 可參考 "http://guides.rubyonrails.org/routing.html" chapter-2.9.2
    #
    get 'index', :on => :collection  

    get 'show_fun_buttons', :on => :collection
    get 'show_paper_content', :on => :collection
    get 'show_ad_list', :on => :collection
    get 'news/report', :on => :collection

    get 'set_filter_setting', :on => :collection
    get 'get_filter_session', :on => :collection
    get 'load_filter_setting', :on => :collection
    get '_show_paper_content', :on => :collection
    get 'set_default_locale', :on => :collection


  end

  resources :mobile do
    get 'index', :on => :collection
    get '_show_paper_content', :on => :collection
    get 'show_news', :on => :collection
  end

  #get "main_page/index"
  #get "main_page/to_main_page"
  #get "main_page/to_mobile_site"
  


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
