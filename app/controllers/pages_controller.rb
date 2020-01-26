class PagesController < ApplicationController
  include ApplicationHelper

  before_action do 
    set_meta_description("Klar Schiff ist eine App um ein digitales Abbild von deinen Dingen, die unterschiedlichen Ablagen in mehreren Räumen verteilt sind, zu erstellen. Klar Schiff hilft dir eine Überblick über die Dinge zu behalten, sie schneller zu finden und auszumisten.")
  end

  layout "landing", except: [:home, :help]

  def home
    title("Home")
  end

  def help
    title("Hilfe")
  end

  def about
    title("Die Geschichte hinter Klar Schiff")
    @early_access_request = EarlyAccessRequest.new
  end

  def landing
    title("Gewinne den Überblick über deine Dinge")
    @early_access_request = EarlyAccessRequest.new
  end

  def landing2
    title("Gegenstände organisieren")
    @early_access_request = EarlyAccessRequest.new
  end
end
