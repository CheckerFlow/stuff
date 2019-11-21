class ApplicationController < ActionController::Base
  def default_url_options
    if Rails.env.development?
      {:host => "3000-de969580-f763-4a5e-b66b-1c94a490ea54.ws-eu01.gitpod.io"}
    else  
      {}
    end
  end    
end
