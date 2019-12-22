class PagesController < ApplicationController
  layout "landing", except: [:home, :help]

  def home
  end

  def help
  end

  def about
    @early_access_request = EarlyAccessRequest.new
  end

  def landing
    @early_access_request = EarlyAccessRequest.new
  end
end
