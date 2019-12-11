class PagesController < ApplicationController
  layout "landing"

  def home
    @early_access_request = EarlyAccessRequest.new
  end
end
