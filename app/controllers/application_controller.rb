class ApplicationController < ActionController::Base
  def default_url_options
    if Rails.env.development?
      {:host => "3000-a876d99d-a7e3-4923-a18b-ea229043f460.ws-eu01.gitpod.io/"}
    else  
      {}
    end
  end    
end
