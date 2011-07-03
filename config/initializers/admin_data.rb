AdminData.config do |config|

  config.number_of_records_per_page = 30

  config.is_allowed_to_view = lambda {|controller| controller.send('admin_logged_in?') }
  config.is_allowed_to_update = lambda {|controller| controller.send('admin_logged_in?') }


  #config.columns_order = { 'News' => [:id, :title, :url ,:created_at, :updated_at] }
end

