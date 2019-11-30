class ApplicationController < ActionController::Base
  def default_url_options
    if Rails.env.development?
      {:host => "localhost"}
    else  
      {}
    end
  end    
end
