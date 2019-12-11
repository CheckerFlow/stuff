class ApplicationController < ActionController::Base
  def default_url_options
    if Rails.env.development?
      {:host => "localhost"}
    else  
      {}
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || pages_home_path
  end  
end
