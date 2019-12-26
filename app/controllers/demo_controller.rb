class DemoController < ApplicationController
  def sign_in
    @user = User.find_by_email("demo@klarschiff.app")
  end
end
