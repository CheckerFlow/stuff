class PagesController < ApplicationController
  layout "landing", except: [:home]
  

  def home
    
  end

  def landing
    @early_access_request = EarlyAccessRequest.new
  end
end
