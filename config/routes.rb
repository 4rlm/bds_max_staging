Rails.application.routes.draw do
  resources :whos do
    collection { post :import_csv_data }
  end
  get 'who_starter_btn' => 'whos#who_starter_btn'
  get 'who/import_page' => 'whos#import_page'
  get 'who/search' => 'whos#search'
  get 'who_power_btn' => 'whos#who_power_btn'
  
  resources :indexer_terms do
    collection { post :import_csv_data }
  end
  get 'indexer_term/import_page' => 'indexer_terms#import_page'

  resources :indexers do
    collection {post :import_csv_data}
    #   get :merge_data, on: :collection
  end
  get 'indexer/search' => 'indexers#search'
  get 'indexer/import_page' => 'indexers#import_page'
  get 'page_finder_btn' => 'indexers#page_finder_btn'
  get 'reset_errors_btn' => 'indexers#reset_errors_btn'
  get 'indexer_power_btn' => 'indexers#indexer_power_btn'
  get 'template_finder_btn' => 'indexers#template_finder_btn'
  get 'rooftop_data_getter_btn' => 'indexers#rooftop_data_getter_btn'
  get 'meta_scraper_btn' => 'indexers#meta_scraper_btn'
  get 'indexer/show_detail' => 'indexers#show_detail'
  get 'url_redirect_checker_btn' => 'indexers#url_redirect_checker_btn'
  get 'score_calculator_btn' => 'indexers#score_calculator_btn'
  get 'scraper_migrator_btn' => 'indexers#scraper_migrator_btn'

  get 'migrate_address_to_staffers_btn' => 'indexers#migrate_address_to_staffers_btn'

  get 'id_sorter_btn' => 'indexers#id_sorter_btn'
  get 'finalizer_btn' => 'indexers#finalizer_btn'
  get 'phone_formatter_finalizer_btn' => 'indexers#phone_formatter_finalizer_btn'
  get 'geo_to_indexer_btn' => 'indexers#geo_to_indexer_btn'
  get 'address_formatter_btn' => 'indexers#address_formatter_btn'
  get 'phone_migrator_btn' => 'indexers#phone_migrator_btn'


  resources :locations do
    collection {post :import_csv_data}
    get :merge_data, on: :collection
    get :flag_data, on: :collection
  end
  get 'location/import_page' => 'locations#import_page'
  get 'location/search' => 'locations#search'
  get 'geo_places_starter_btn' => 'locations#geo_places_starter_btn'
  get 'location_power_btn' => 'locations#location_power_btn'
  get 'turbo_matcher_btn' => 'locations#turbo_matcher_btn'
  get 'location_cleaner_btn' => 'locations#location_cleaner_btn'
  get 'geo_update_migrate_btn' => 'locations#geo_update_migrate_btn'
  # get 'geo_starter_btn' => 'locations#geo_starter_btn'

  resources :staffers do
    collection { post :import_csv_data }
  end
  get 'staffer/import_page' => 'staffers#import_page'
  get 'staffer/search' => 'staffers#search'
  get 'staffer/acct_contacts' => 'staffers#acct_contacts'
  get 'cs_data_getter_btn' => 'staffers#cs_data_getter_btn'
  get 'staffer_sfdc_id_cleaner_btn' => 'staffers#staffer_sfdc_id_cleaner_btn'
  get 'staffer_power_btn' => 'staffers#staffer_power_btn'
  get 'crm_staff_counter_btn' => 'staffers#crm_staff_counter_btn'

  resources :cores do
    collection { post :import_core_data }
    get :merge_data, on: :collection
    get :flag_data, on: :collection
    get :drop_data, on: :collection
  end
  get 'core/import_page' => 'cores#import_page'
  get 'core/search' => 'cores#search'
  # # Clean Data Buttons
  # get 'core_comp_cleaner_btn' => 'cores#core_comp_cleaner_btn'
  get 'core_power_btn' => 'cores#core_power_btn'
  get 'col_splitter_btn' => 'cores#col_splitter_btn'

  resources :in_host_pos do
    collection { post :import_csv_data }
  end
  get 'in_host_po/import_page' => 'in_host_pos#import_page'

  resources :dashboards do
    collection { post :import_csv_data }
  end
  get 'dashboard/import_page' => 'dashboards#import_page'
  get 'dashboard_mega_btn' => 'dashboards#dashboard_mega_btn'
  get 'cores_dash_btn' => 'dashboards#cores_dash_btn'
  get 'delayed_jobs_dash_btn' => 'dashboards#delayed_jobs_dash_btn'
  get 'franchise_dash_btn' => 'dashboards#franchise_dash_btn'
  get 'indexer_dash_btn' => 'dashboards#indexer_dash_btn'
  get 'geo_locations_dash_btn' => 'dashboards#geo_locations_dash_btn'
  get 'staffers_dash_btn' => 'dashboards#staffers_dash_btn'
  get 'users_dash_btn' => 'dashboards#users_dash_btn'
  get 'whos_dash_btn' => 'dashboards#whos_dash_btn'
  get 'summarize_data' => 'dashboards#summarize_data'
  get 'dashboard_power_btn' => 'dashboards#dashboard_power_btn'


  devise_for :users

  #==== Delayed_Jobs_Interface Starts=========
  # match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # #==== Search Pages Start=========
  post 'search_result_page_core' => 'search#search_result_core'
  post 'search_result_page_staffer' => 'search#search_result_staffer'
  post 'search_result_page_location' => 'search#search_result_location'
  post 'search_result_page_indexer' => 'search#search_result_indexer'
  post 'search_result_page_indexer' => 'search#search_result_indexer'


  get 'admin/index'
  get 'admin/starters'
  get 'admin/change_user_level' => 'admin#change_user_level'
  get 'admin/delete_user' => 'admin#delete_user'
  get 'admin/developer' => 'admin#developer'

  root 'welcome#index'


  # Hide all CRUD actions 2017.03.10 ==================================

  # # === Google API Route ===
  # get '/search' => 'search#index'

  # resources :in_text_pos do
  #     collection { post :import_csv_data }
  # end
  # get 'in_text_po/import_page' => 'in_text_pos#import_page'
end
